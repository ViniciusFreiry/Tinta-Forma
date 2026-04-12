index = 0;
target = noone;
x_offset = -10;
y_offset = -15;
y_spd = 1;

move = function() {
	if(target == noone) return;
	
	var _x_offset = x_offset * target.image_xscale;
	x = lerp(x, target.x + _x_offset + _x_offset * (1 - (index / array_length(target.keys))), 0.2);
	
	var _sin_wave = generate_sin_wave(5, current_time + index * 100) * 5;
	y = lerp(y, target.y + y_offset + _sin_wave, 0.05);
	
	image_xscale = -target.image_xscale;
}

move_to_door = function() {
	x = lerp(x, target.x, 0.2);
	y = lerp(y, target.y, 0.2);
	
	if(point_distance(x, y, target.x, target.y) < 0.1) {
		image_xscale = lerp(image_xscale, 0, 0.1);
		image_yscale = abs(image_xscale);
		
		if(image_yscale < 0.1) {
			target.open_self();
			instance_destroy();
		}
	}
}

state = move;