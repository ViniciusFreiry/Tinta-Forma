if(instance_exists(obj_particle_shoot)) {
	gpu_set_blendmode(bm_add);
		
	with(obj_particle_shoot) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
		
	gpu_set_blendmode(bm_normal);
}