index = 0;
target = noone;
x_offset = -10;
y_offset = -20;
y_spd = 1;

move = function() {
	if(target == noone) return;
	
	if(target.key_qtd < index) instance_destroy();
	
	var _x_offset = x_offset * target.image_xscale;
	
	x = lerp(x, target.x + _x_offset + _x_offset * (1 - (index / target.key_qtd)), 0.2);
	y = lerp(y, target.y + y_offset, 0.05);
	
	y_offset += y_spd;
	
	if(y_offset >= -4 or y_offset <= -20) y_spd *= -1;
	
	image_xscale = -target.image_xscale;
}