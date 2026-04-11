#region Variables
// Moviment Variables
hspd = 0;
vspd = 0;
max_hspd = 1;
max_vspd = 5;
grav = 0.3;

// Collisions
collision_ink = layer_tilemap_get_id("Ink");
collision_tl = layer_tilemap_get_id("Level")
collisions = [obj_wall, collision_tl];

// Level Variables
ground = false;
ground_ink = false;

// Inputs Variables
left = 0
right = 0;
jump = 0;
jump_r = 0;
ink = 0;

// State Variables
state = noone;
sprites_list = [spr_player_idle];
sprites_list_index = 0;

// Power Up Variables
power_ink = false;

// Itens Variables
key_qtd = 0;

// Game Feel Initializes
initialize_stretch();
initialize_shader_draw();
#endregion

#region Functions
change_sprite_with_animation = function() {
	if(animation_end() and array_length(sprites_list) - 1 > sprites_list_index) sprites_list_index++;
	
	return change_sprite(sprites_list[sprites_list_index]);
}

change_state = function(_state = idle_state, _sprites_list = [spr_player_idle]) {
	state = _state;
	sprites_list_index = 0;
	sprites_list = _sprites_list;
}

inputs = function() {
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	jump = keyboard_check_pressed(vk_space);
	jump_r = keyboard_check_released(vk_space);
	ink = keyboard_check(vk_shift);
}

apply_spd = function() {
	ground_check();
	
	hspd = (right - left) * max_hspd;
	
	if (ground) {
		vspd = 0;
		y = round(y);
		
		if (jump and state != jump_state) vspd = -max_vspd;
	} else {
		vspd += grav;
	}
	
	vspd = clamp(vspd, -max_vspd, max_vspd);
}

adjust_scale = function() {
	if(hspd != 0) image_xscale = sign(hspd);
}

move = function() {
	move_and_collide(hspd, 0, collisions, 12);
	move_and_collide(0, vspd, collisions, 12);
}

ground_check = function() {
	ground = place_meeting(x, y + 1, collisions);
	ground_ink = place_meeting(x, y + 1, collision_ink);
}

take_power_up = function() {
	state = power_up_start_state;
}

take_key = function() {
	key_qtd++;
}

open_door = function() {
	var _door = instance_place(x + hspd, y + vspd, obj_door);
	
	if(_door and _door.closed and key_qtd > 0) {
		_door.open_self();
		key_qtd--;
	}
}

// State Functions
idle_state = function() {
	vspd = 0;
	hspd = 0;
	apply_spd();
	
	if(change_sprite_with_animation()) mask_index = spr_player_idle;
	
	if(left != right) change_state(moving_state, [spr_player_idle_to_run, spr_player_run]);
	
	if(ink and power_ink and ground_ink) state = enter_ink_state;
	
	if(!ground) change_state(jump_state, [spr_player_fall]);
	
	if(jump) change_state(jump_state, [spr_player_start_jump, spr_player_jump]);
}

moving_state = function() {
	apply_spd();
	
	change_sprite_with_animation();
	
	if(left == right) change_state(idle_state, [spr_player_run_to_idle, spr_player_idle]);
	
	if(ink and power_ink and ground_ink) state = enter_ink_state;
	
	if(!ground) change_state(jump_state, [spr_player_fall]);
	
	if(jump) change_state(jump_state, [spr_player_start_jump, spr_player_jump]);
}

jump_state = function() {
	apply_spd();
	
	var _collisions = [obj_wall, collision_tl];
	if(hit_the_ceil(vspd, _collisions)) vspd = 0;
	
	if(vspd < 0) {
		if(jump_r) vspd /= 2;
		
		if(change_sprite_with_animation() and sprite_index == spr_player_start_jump) {
			instance_create_depth(x, y - vspd, depth - 1, obj_player_jump_particle);
			set_stretch(0.4, 1.6);
		}
		
		if(array_contains(collisions, obj_wall_one_way)) array_delete(collisions, array_get_index(collisions, obj_wall_one_way), 1);
	} else {
		if(sprites_list[0] != spr_player_jump_to_fall and sprites_list[0] != spr_player_fall) {
			image_index = 0;
			change_state(jump_state, [spr_player_jump_to_fall, spr_player_fall]);
		}
		
		if(vspd > 0) {
			change_sprite_with_animation();
		} else if(ground) {
			change_state(idle_state, [spr_player_land, spr_player_idle]);
			instance_create_depth(x, y, depth - 1, obj_player_fall_particle);
			set_stretch(1.2, 0.5);
		}
		
		if(!array_contains(collisions, obj_wall_one_way) and !place_meeting(x, y, obj_wall_one_way)) array_push(collisions, obj_wall_one_way);
	}
}

power_up_start_state = function() {
	change_sprite(spr_player_powerup_start);
	
	hspd = 0;
	vspd = 0;
	
	if(animation_end()) state = power_up_wait_state;
}

power_up_wait_state = function() {
	if(!change_sprite(spr_player_powerup_wait)) {
		if(!instance_exists(obj_particle_power_up)) state = power_up_final_state;
	}
}

power_up_final_state = function() {
	change_sprite(spr_player_powerup_final);
	
	if(animation_end()) change_state(idle_state, [spr_player_idle]);
}

enter_ink_state = function() {
	if(change_sprite(spr_player_enter_ink)) {
		instance_create_depth(x, y, depth - 1, obj_player_enter_ink_particles);
	}
	
	hspd = 0;
	vspd = 0;
	
	if(animation_end()) change_state(ink_state, [spr_player_ink_start, spr_player_ink_loop]);
}

ink_state = function() {
	if(change_sprite_with_animation()) mask_index = spr_player_ink_loop;
	
	apply_spd();
	vspd = 0;
	
	if(!check_ground_in_front(hspd, sprite_index, collision_ink)) hspd = 0;
	
	if(ink) {
		mask_index = spr_player_idle;
		
		if(!place_meeting(x, y, collisions)) change_state(exit_ink_state, [spr_player_ink_end, spr_player_exit_ink]);
		else mask_index = spr_player_ink_loop;
	}
}

exit_ink_state = function() {
	if(change_sprite_with_animation() and sprite_index == spr_player_exit_ink) {
		instance_create_depth(x, y, depth - 1, obj_player_exit_ink_particles);
	}
	
	hspd = 0;
	vspd = 0;
	
	if(animation_end() and sprite_index == spr_player_exit_ink) change_state(idle_state, [spr_player_idle]);
}
#endregion

#region Debug
view_player_debug = noone;

draw_debug = function() {
	if(!global.debug) return;
	
	draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
}

show_debug = function() {
	show_debug_overlay(global.debug);
	
	if(!global.debug) {
		if(dbg_view_exists(view_player_debug)) dbg_view_delete(view_player_debug);
		return;
	}
	
	view_player_debug = dbg_view("View Player", 1, 20, 100, 400, 200);
	
	dbg_watch(ref_create(id, "x"), "x");
	dbg_watch(ref_create(id, "y"), "y");
	
	dbg_watch(ref_create(id, "hspd"), "hspd");
	dbg_watch(ref_create(id, "vspd"), "vspd");

	dbg_slider(ref_create(id, "max_vspd"), 0, 10, "Jump Force", 0.1);
	dbg_slider(ref_create(id, "grav"), 0, 2, "Gravity", 0.05);
}

debug_check = function() {
	if(!DEBUG_MODE) return;
	
	if(keyboard_check_pressed(vk_f12)) {
		global.debug = !global.debug;
	
		show_debug();
	}
}
#endregion

state = idle_state;