target = noone;
x_offset = 0;
y_offset = -40;

move_to_player = function() {
	if(!target) return;
	
	x = lerp(x, target.x + x_offset * target.image_xscale, 0.1);
	y = lerp(y, target.y + y_offset * target.image_yscale, 0.1);
}

power_up_part = function() {
	if(target == noone) return;
	
	if(target.image_index == 0) {
		switch(target.sprite_index) {
			case spr_player_powerup_wait:
				if(!instance_exists(obj_particle_power_up)) {
					create_particles("Decorations_Objects", Particles.POWER_UP, 30, 60, x, y, 0, 0, 2, 3, 0, 50, 100, c_white, c_aqua, 1);
					set_target_power_up_particles(target, 0, -10);
				}
			break;
			
			case spr_player_idle:
				x_offset = -10;
				y_offset = -35;
			break;
		}
	}
}