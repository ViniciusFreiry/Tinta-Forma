generic_method = function(_player) {
	
}

stop_player = function(_player) {
	var _new_state = function() {
		hspd = 0;
		vspd += grav;
		change_sprite_with_animation();
	}
	
	with(_player) {
		var _state = method(id, _new_state);
		change_state(_state, [spr_player_fall]);
	}
}

return_player = function(_player) {
	if(!instance_exists(obj_player_shadow)) {
		var _shadow = instance_create_layer(_player.x, _player.y, "Dialog", obj_player_shadow);
		
		_shadow.target_x = return_x;
		_shadow.target_y = return_y;
		_shadow.owner = _player;
		_shadow.sprite_index = _player.sprite_index;
		_shadow.image_xscale = _player.image_xscale;
	}
}

define_position = function(_player) {
	global.player_x = return_x;
	global.player_y = return_y;
	global.player_xscale = player_xscale;
	
	create_my_save();
}

generic_method = variable_instance_get(id, mode);