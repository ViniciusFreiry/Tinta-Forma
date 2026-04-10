if(place_meeting(x, y, obj_player)) {
	if(instance_exists(my_dialog_box)) my_dialog_box.destroy_dialog = false;
	else {
		my_dialog_box = instance_create_layer(x, y - 9, "Dialog", obj_dialog);
		
		my_dialog_box.text = my_text;
	}
} else {
	if(instance_exists(my_dialog_box)) my_dialog_box.destroy_dialog = true;
}