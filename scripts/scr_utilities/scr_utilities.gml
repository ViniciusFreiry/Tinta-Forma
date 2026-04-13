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

function generate_sin_wave(_frequency = 5, _current_time = current_time) {
	return sin(_frequency * _current_time / 1000);
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

#region Save
global.actual_save_slot = 1;

function set_save_slot(_slot = 1) {
	global.actual_save_slot = _slot;
}

function get_save_slot() {
	return global.actual_save_slot;
}

function save_game(_variables_to_save = [], _save_number = global.actual_save_slot) {
	var _save_struct = { deleted_file: false };
	
	for(var _i = 0; _i < array_length(_variables_to_save); _i++) {
		variable_struct_set(_save_struct, _variables_to_save[_i], variable_global_get(_variables_to_save[_i]));
	}
	
	var _buffer = buffer_create(0, buffer_grow, 1);

	buffer_write(_buffer, buffer_string, json_stringify(_save_struct));
	buffer_save(_buffer, string("save_{0}.json", _save_number));

	buffer_delete(_buffer);
	delete _save_struct;
}

function load_saved_game(_save_number = global.actual_save_slot) {
	var _buffer = buffer_load(string("save_{0}.json", _save_number));
	
	if(_buffer == -1) return;
	
	var _struct = json_parse(buffer_read(_buffer, buffer_string));
	
	if(_struct.deleted_file) {
		delete _struct;
		return;
	}
	
	var _variables = struct_get_names(_struct);
	
	for(var _i = 0; _i < array_length(_variables); _i++) {
		variable_global_set(_variables[_i], _struct[$ _variables[_i]]);
	}
	
	buffer_delete(_buffer);
	delete _struct;
}

function delete_saved_game(_save_number = global.actual_save_slot) {
	var _buffer = buffer_load(string("save_{0}.json", _save_number));
	
	if(_buffer == -1) return;
	
	var _struct = json_parse(buffer_read(_buffer, buffer_string));
	
	_struct.deleted_file = true;
	
	buffer_delete(_buffer);
	
	_buffer = buffer_create(0, buffer_grow, 1);
	
	buffer_write(_buffer, buffer_string, json_stringify(_struct));
	buffer_save(_buffer, string("save_{0}.json", _save_number));
	
	buffer_delete(_buffer);
	delete _struct;
}
#endregion