draw_self();

if(!can_draw) {
	typewrite = 0;
	exit;
}

var _marg = 4;

typewrite++;

draw_set_font(fnt_sign);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_rich_text(x, y, text, -2, sprite_width - _marg * 2, 0.1, 0.1, typewrite);

draw_set_font(-1);
draw_set_valign(-1);
draw_set_halign(-1);