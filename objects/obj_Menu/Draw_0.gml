draw_sprite_stretched(spr_Box, 0, x, y, widthFull, heightFull);
draw_set_color(c_white);
draw_set_font(DefaultFont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = (description != -1);
var _scrollPush = max(0, hover - (visibleOptionsMax - 1));

for (var l = 0; l < (visibleOptionsMax + _desc); l++) {
	if (l >= array_length(options)) break;
	draw_set_color(c_white);
	if (l == 0) && (_desc) {
		draw_set_color(c_yellow);
		draw_text_transformed(x + xMargin, y + yMargin, description, 0.5, 0.5, 0);
		draw_set_color(c_white);
	}
	else {
		var _optionToShow = l - _desc + _scrollPush;
		var _str = options[_optionToShow].name;
		if (hover == _optionToShow - _desc) draw_set_color(c_teal);	
		if (options[_optionToShow].avail == false) draw_set_color(c_gray);
		draw_text_transformed(x + xMargin, y + yMargin + l * heightLine, _str, 0.5, 0.5, 0);
	}
}

//Draw pointer if needed here
draw_sprite(spr_pointer, spriteFrame, x + xMargin + 7, y + yMargin + ((hover - _scrollPush) * heightLine) + 5);
if (visibleOptionsMax < array_length(options)) && (hover < array_length(options) - 1) {
	draw_sprite(spr_DownArrow, 0, x + widthFull * 0.5, y + heightFull - 7);
}