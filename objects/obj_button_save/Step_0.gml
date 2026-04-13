var _mouse_in = position_meeting(mouse_x, mouse_y, id);

if(_mouse_in) {
	image_alpha = 0.9;
	sprite = spr_player_run;
	
	if(mouse_check_button_released(mb_left)) {
		set_save_slot(number);
		load_saved_game();
		set_square_transition(global.actual_room);
	}
	
	if(keyboard_check_pressed(vk_delete)) delete_saved_game(number);
} else {
	image_alpha = 0.6;
	sprite = spr_player_idle;
}