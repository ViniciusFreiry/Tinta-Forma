function check_ground_in_front(_hspd, _sprite, _collisions) {
	return place_meeting(x + (sign(_hspd) * sprite_get_width(_sprite)), y + 1, _collisions);
}

function hit_the_ceil(_vspd, _collisions) {
	return place_meeting(x, y + sign(_vspd), _collisions);
}

#region Coyote Jump
function initialize_coyote_jump(_coyote_time = game_get_speed(gamespeed_fps) / 10) {
	coyote_timer = _coyote_time;
	actual_coyote_timer = coyote_timer;
}

function run_coyote_jump(_in_ground) {
	if(_in_ground) actual_coyote_timer = coyote_timer;
	else actual_coyote_timer--;
}

function check_coyote_jump() {
	return (actual_coyote_timer > 0 ? true : false);
}

function stop_coyote_timer() {
	actual_coyote_timer = 0;
}
#endregion