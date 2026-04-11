inputs();
move();
adjust_scale();
state();
open_door();

run_stretch(0.1);
run_shader_draw();

debug_check();

if(keyboard_check_pressed(ord("R"))) set_square_transition(room);

if(keyboard_check_pressed(vk_f11)) window_set_fullscreen(!window_get_fullscreen());