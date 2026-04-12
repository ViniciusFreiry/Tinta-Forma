if(target == noone) {
	target = other;
	
	if(!global.ink_power_up) {
		other.take_power_up();
		other.power_ink = true;
		global.ink_power_up = true;
	} else {
		x_offset = -10;
		y_offset = -35;
	}
}