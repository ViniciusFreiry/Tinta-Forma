target = noone;

move_to_player = function() {
	if(!target) return;
	
	x = lerp(x, target.x, 0.1);
	y = lerp(y, target.y - 40, 0.1);
}