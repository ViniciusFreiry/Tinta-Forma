if(other.actual_life < 0) {
	instance_destroy(other);

	set_stretch(random_range(1.1, 1.3), random_range(1.1, 1.3));
	screen_shake(2);
}