draw_self();

draw_sprite_ext(sprite, current_time / 100, x - 100, y + 12, 1, 1, 0, c_white, image_alpha);

draw_set_font(fnt_save_button);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_rich_text(x, y, text, 0, sprite_width, 0.15, 0.15);

draw_set_font(-1);
draw_set_halign(-1);
draw_set_valign(-1);