closed = true;
wainting_for_open = false;
vspd = -0.5;

//ps_door_opening
ps = part_system_create();
part_system_draw_order(ps, true);

//Emitter
ptype1 = part_type_create();
part_type_shape(ptype1, pt_shape_smoke);
part_type_size(ptype1, 1, 1, 0.1, 0);
part_type_scale(ptype1, 0.1, 0.1);
part_type_speed(ptype1, 0.1, 0.1, 0, 0);
part_type_direction(ptype1, 80, 100, 0, 0);
part_type_gravity(ptype1, 0, 270);
part_type_orientation(ptype1, 0, 0, 0, 0, false);
part_type_colour3(ptype1, $000000, $4C4C4C, $191919);
part_type_alpha3(ptype1, 1, 1, 0.122);
part_type_blend(ptype1, true);
part_type_life(ptype1, 20, 40);


open_self = function() {
	closed = false;
}

// State Variables
closed_state = function() {
	if(!closed) state = opening_state;
}

opening_state = function() {
	var _part_x = x + random_range(-sprite_width / 2, sprite_width / 2),
	_part_y = ystart - 16;
	
	y += vspd;
	x = xstart + irandom_range(-1, 1);
	
	screen_shake(3);
	
	part_particles_create(ps, _part_x, _part_y, ptype1, 1);
	
	if(y <= ystart - sprite_height) {
		alarm[0] = FPS;
		
		x = xstart;
		state = open_state;
	}
}

open_state = function() {
	
}

state = closed_state;