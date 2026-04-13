if(target == noone) {
	target = other;
	
	if(!variable_global_get(power_up)) {
		variable_global_set(power_up, true);
		other.take_power_up();
	} else {
		x_offset = -10;
		y_offset = -35;
	}
}