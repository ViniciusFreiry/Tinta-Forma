generic_method = function(_player) {
	if(!instance_exists(obj_player_shadow)) {
		var _shadow = instance_create_layer(_player.x, _player.y, "Dialog", obj_player_shadow);
		
		_shadow.target_x = 304;
		_shadow.target_y = 432;
		_shadow.owner = _player;
		_shadow.sprite_index = _player.sprite_index;
	}
}