// State Variables
state_solid = function() {
	image_index = 0;
	
	mask_index = spr_dice_block;
	if(place_meeting(x, y, obj_player)) mask_index = spr_noone;
	
	timer--;
	
	if(timer <= switch_time) {
		timer += switch_time;
		
		state = state_going_to_not_solid;
	}
}

state_going_to_not_solid = function() {
	if(image_index >= 8) state = state_not_solid;
}

state_not_solid = function() {
	image_index = 8;
	mask_index = spr_noone;
	
	timer--;
	
	if(timer <= switch_time) {
		timer += switch_time;
		
		state = state_going_to_solid;
	}
}

state_going_to_solid = function() {
	if(animation_end()) state = state_solid;
}

state = (start_solid ? state_solid : state_not_solid);