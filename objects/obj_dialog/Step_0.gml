if(destroy_dialog) {
	can_draw = false;
	
	image_xscale = lerp(image_xscale, 0, 0.1);
	image_yscale = lerp(image_yscale, 0, 0.1);
	image_alpha = lerp(image_alpha, 0, 0.1);
	
	y = lerp(y, ystart, 0.1);
	
	if(image_xscale <= 0.1) instance_destroy();
} else {
	image_xscale = lerp(image_xscale, 2.5, 0.2);
	image_yscale = lerp(image_yscale, 1, 0.2);
	image_alpha = lerp(image_alpha, 0.75, 0.1);

	y = lerp(y, ystart - 35, 0.2);

	if(image_xscale >= 2.4) can_draw = true;
}