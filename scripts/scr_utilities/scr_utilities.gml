#macro DEBUG_MODE false
#macro FPS game_get_speed(gamespeed_fps)

#macro Debug_Mode:DEBUG_MODE true

global.debug = false;

function change_sprite(_sprite) {
	if(sprite_index != _sprite) {
		sprite_index = _sprite;
		image_index = 0;
		return true;
	}
	
	return false;
}

function animation_end() {
	var _spd = sprite_get_speed(spr_player_powerup_start) / FPS;
	
	if(image_index + _spd >= image_number) return true;
	
	return false;
}

function check_ground_in_front(_hspd, _sprite, _obj_to_check) {
	return place_meeting(x + (sign(_hspd) * sprite_get_width(_sprite)), y + 1, _obj_to_check);
}