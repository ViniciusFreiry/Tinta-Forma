#region Variables
// Moviment Variables
hspd = 0;
vspd = 0;
max_hspd = 1;

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
	
	move_and_collide(hspd, vspd, obj_wall);
}
#endregion