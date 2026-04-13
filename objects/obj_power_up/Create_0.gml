target = noone;
x_offset = 0;
y_offset = -40;

initialize_shader_draw();

switch(power_up) {
	case "ink_power_up":
		if(global.ink_power_up) {
			x_offset = -20;
			y_offset = -35;
		
			if(!place_meeting(x, y, obj_player)) instance_destroy(id, false);
		}
	break;
	
	case "run_power_up":
		image_blend = c_fuchsia;
		depth = depth + 1;
	
		if(global.run_power_up) {
			x_offset = -25;
			y_offset = -35;
		
			if(!place_meeting(x, y, obj_player)) instance_destroy(id, false);
		}
	break;
}

move_to_player = function() {
	var _sin_wave;

	switch(power_up) {
		case "ink_power_up": _sin_wave = generate_sin_wave(3) * 4; break;
			
		case "run_power_up": _sin_wave = generate_sin_wave(3, current_time + 100) * 4; break;
	}
	
	if(!target) {
		y = lerp(y, ystart + _sin_wave, 0.1);
		
		return;
	}
	
	var _y_target = (target.sprite_index == spr_player_powerup_start 
	or target.sprite_index == spr_player_powerup_wait 
	or target.sprite_index == spr_player_powerup_final
	? target.y + y_offset * target.image_yscale
	: target.y + y_offset * target.image_yscale + _sin_wave);
	
	x = lerp(x, target.x + x_offset * target.image_xscale, 0.1);
	y = lerp(y, _y_target, 0.1);
}

power_up_part = function() {
	if(target == noone or y_offset != -40) return;
	
	if(target.image_index == 0) {
		switch(target.sprite_index) {
			case spr_player_powerup_wait:
				if(!instance_exists(obj_particle_power_up)) {
					var _qtd = irandom_range(50, 100);
					
					for(var _i = 0; _i < _qtd; _i++) {
						create_particles("Decorations_Objects", Particles.POWER_UP, 30, 60, x, y, 0, 0, 2, 3, 0, 1, 1, c_white, choose(c_aqua, c_red, c_yellow, c_lime, c_orange, c_fuchsia), 1);
					}
					
					set_target_power_up_particles(target, 0, -10);
					set_shader_draw(-30, c_white, 0.5, true);
				}
			break;
			
			case spr_player_idle:
				y_offset = -35;
			
				switch(power_up) {
					case "ink_power_up": x_offset = -20; break;
			
					case "run_power_up": x_offset = -25; break;
				}
			break;
		}
	}
	
	if(shader_draw == -1) set_shader_draw(60, c_white, 0.5, true);
}