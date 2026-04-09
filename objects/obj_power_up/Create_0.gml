target = noone;
x_offset = 0;
y_offset = -40;

initialize_shader_draw();

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
					var _qtd = irandom_range(50, 100);
					
					for(var _i = 0; _i < _qtd; _i++) {
						create_particles("Decorations_Objects", Particles.POWER_UP, 30, 60, x, y, 0, 0, 2, 3, 0, 1, 1, c_white, choose(c_aqua, c_red, c_yellow, c_lime, c_maroon, c_fuchsia), 1);
					}
					
					set_target_power_up_particles(target, 0, -10);
					set_shader_draw(-30, c_white, 0.5, true);
				}
			break;
			
			case spr_player_idle:
				x_offset = -10;
				y_offset = -35;
			break;
		}
	}
	
	if(shader_draw == -1) set_shader_draw(60, c_white, 0.5, true);
}