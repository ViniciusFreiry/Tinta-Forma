generic_method = function(_player) {
	var _new_state = function() {
		hspd = 0;
		change_sprite_with_animation();
	}
	
	with(_player) {
		var _state = method(id, _new_state);
		change_state(_state, [spr_player_fall]);
	}
}