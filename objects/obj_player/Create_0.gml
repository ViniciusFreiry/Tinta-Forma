#region Variables
// Moviment Variables
hspd = 0;
vspd = 0;
max_hspd = 1;
max_vspd = 5;
grav = 0.3;

// Level Variables
ground = false;

// Inputs Variables
left = 0
right = 0;
jump = 0;

// State Variables
state = noone;

// Game Feel Initialize
initialize_stretch();
#endregion

#region Functions
inputs = function() {
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	jump = keyboard_check(vk_space);
}

apply_spd = function() {
	ground_check();
	
	hspd = (right - left) * max_hspd;
	
	if (ground) {
		vspd = 0;
		y = round(y);
		
		if (jump) vspd = -max_vspd;
	} else {
		vspd += grav;
	}
}

adjust_scale = function() {
	if(hspd != 0) image_xscale = sign(hspd);
}

move = function() {
	move_and_collide(hspd, 0, obj_wall, 12);
	move_and_collide(0, vspd, obj_wall, 12);
}

ground_check = function() {
	ground = place_meeting(x, y + 1, obj_wall);
}

// State Functions
idle_state = function() {
	vspd = 0;
	hspd = 0;
	apply_spd();
	
	change_sprite(spr_player_idle);
	
	if(left != right) state = moving_state;
	
	if(jump) state = jump_state;
	
	if(!ground) state = jump_state;
}

moving_state = function() {
	apply_spd();
	
	change_sprite(spr_player_run);
	
	if(left == right) state = idle_state;
	
	if(jump) state = jump_state;
	
	if(!ground) state = jump_state;
}

jump_state = function() {
	apply_spd();
	
	if(vspd > 0) change_sprite(spr_player_fall);
	else if(vspd < 0) {
		if(change_sprite(spr_player_jump)) {
			if(ground) instance_create_depth(x, y, depth - 1, obj_player_jump_particle);
			else instance_create_depth(x, y - vspd, depth - 1, obj_player_jump_particle);
			
			set_stretch(0.4, 1.6);
		}
	} else if(ground) {
		state = idle_state;
		instance_create_depth(x, y, depth - 1, obj_player_fall_particle);
		set_stretch(1.2, 0.5);
	}
}

power_up_start_state = function() {
	change_sprite(spr_player_powerup_start);
	
	hspd = 0;
	vspd = 0;
	
	if(animation_end()) state = power_up_wait_state;
}

power_up_wait_state = function() {
	change_sprite(spr_player_powerup_wait);
	
	if(animation_end()) state = power_up_final_state;
}

power_up_final_state = function() {
	change_sprite(spr_player_powerup_final);
	
	if(animation_end()) state = idle_state;
}

enter_ink_state = function() {
	change_sprite(spr_player_enter_ink);
	
	hspd = 0;
	vspd = 0;
}

exit_ink_state = function() {
	change_sprite(spr_player_exit_ink);
	
	hspd = 0;
	vspd = 0;
	
	if(animation_end()) state = idle_state;
}
#endregion

#region Debug
view_player_debug = noone;

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