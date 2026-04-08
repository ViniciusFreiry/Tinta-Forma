function initialize_shader_draw() {
	shader_draw = 0;
}

function set_shader_draw(_frames) {
	shader_draw = _frames
}

function run_shader_draw() {
	if (shader_draw > 0) shader_draw--;
}

function use_shader_draw(_draw_function = draw_self, _shader = sh_draw_white) {
	if (shader_draw > 0) {
		shader_set(_shader);
		_draw_function();
		shader_reset();
	} else {
		_draw_function();	
	}
}