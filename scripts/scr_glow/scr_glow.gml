function glow(_scale_multipli = 1.1, _colour = c_white, _alpha = 0.5) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * _scale_multipli, image_yscale * _scale_multipli, image_angle, _colour, _alpha);
	gpu_set_blendmode(bm_normal);	
}