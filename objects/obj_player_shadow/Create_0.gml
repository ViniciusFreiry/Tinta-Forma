target_x = 0;
target_y = 0;

owner = noone;

image_alpha = 0.5;

camera_set_view_target(view_camera, id);

with(obj_power_up) {
	if(target != noone) target = other.id;
}