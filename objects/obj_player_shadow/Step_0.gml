owner.image_alpha = 0;

x = lerp(x, target_x, 0.1);
y = lerp(y, target_y, 0.2);

create_trial(id, sprite_index, 0.9, 0.9, true);

if(point_distance(x, y, target_x, target_y) <= 0.5) {
	owner.x = target_x;
	owner.y = target_y;
	owner.image_alpha = 1;
	
	camera_set_view_target(view_camera, owner);
	with(owner) change_state(jump_state, [spr_player_fall]);
	
	instance_destroy();
}