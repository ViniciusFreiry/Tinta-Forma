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
	var _spd = sprite_get_speed(spr_player_powerup_start) / FPS * image_speed;
	
	if(image_index + _spd >= image_number) return true;
	
	return false;
}

#region States with Animation
function initialize_states_with_animation(_sprite = sprite_index) {
	state = noone;
	sprites_list = [_sprite];
	sprites_list_index = 0;
}

function change_sprite_with_animation() {
	if(animation_end() and array_length(sprites_list) - 1 > sprites_list_index) sprites_list_index++;
	
	return change_sprite(sprites_list[sprites_list_index]);
}

function change_state(_state, _sprites_list) {
	state = _state;
	sprites_list_index = 0;
	sprites_list = _sprites_list;
}
#endregion

function generate_sin_wave(_frequency = 5, _current_time = current_time) {
	return sin(_frequency * _current_time / 1000);
}