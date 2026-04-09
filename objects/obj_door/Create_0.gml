closed = true;
vspd = -0.5;

open_self = function() {
	closed = false;
}

// State Variables
closed_state = function() {
	if(!closed) state = opening_state;
}

opening_state = function() {
	y += vspd;
	
	if(y <= ystart - sprite_height) state = open_state;
}

open_state = function() {
	instance_destroy();
}

state = closed_state;