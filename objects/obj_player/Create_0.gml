#region Variables
// Moviment Variables
hspd = 0;
vspd = 0;
max_hspd = 1;
max_vspd = 3;
grav = 0.2;

// Level Variables
ground = false;

// Inputs Variables
left = 0
right = 0;
jump = 0;
#endregion

#region Functions
inputs = function() {
	left = keyboard_check(ord("A"));
	right = keyboard_check(ord("D"));
	jump = keyboard_check(vk_space);
}

move = function() {
	hspd = (right - left) * max_hspd;
	
	if (ground) {
		vspd = 0;
		y = round(y);
		
		if (jump) vspd = -max_vspd;
	} else {
		vspd += grav;
	}
	
	move_and_collide(hspd, 0, obj_wall, 12);
	move_and_collide(0, vspd, obj_wall, 12);
}

ground_check = function() {
	ground = place_meeting(x, y + 1, obj_wall);
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
	
	dbg_watch(ref_create(id, "y"), "y");
	dbg_watch(ref_create(id, "x"), "x");

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