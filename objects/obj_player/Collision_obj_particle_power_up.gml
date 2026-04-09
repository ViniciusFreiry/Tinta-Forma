if(other.actual_life < 0) {
	instance_destroy(other);

	set_stretch(random_range(1.1, 1.3), random_range(1.1, 1.3));
	set_shader_draw(30, other.final_colour, 0.5, true);
	screen_shake(2);
}