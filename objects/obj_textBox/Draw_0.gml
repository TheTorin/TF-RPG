var advanceKey = input_check_pressed("accept") or input_check_pressed("action") or input_check_pressed("shoot");

textbox_X = camera_get_view_x(view_camera[0]);
textbox_Y = camera_get_view_y(view_camera[0]) + 103;

draw_set_font(DefaultFont);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

if (!setup) {
	setup = true;
	drawChar = 0;
	text = TXT_CURR_DIALOGUE.text;
	textLen = string_length(text);
}
		
xOffset = xShift * TXT_CURR_DIALOGUE.xOffset;

//Skip / flip page
if advanceKey and (!instance_exists(obj_Menu)){
	if drawChar == textLen {
		nextDialogue();
	}
	else {
		drawChar = textLen;
	}
}

if (drawChar < textLen) {
		drawChar += textSpeed;
		drawChar = clamp(drawChar, 0, textLen);
}

if (drawChar == textLen and variable_struct_exists(TXT_CURR_DIALOGUE, "options") and !instance_exists(obj_Menu)) {
	//Create options for menu and decide height/placement
	var numOptions = array_length(TXT_CURR_DIALOGUE.options);
	var _options = [];
	for (var i = 0; i < numOptions; i++) {
		var _currOption = TXT_CURR_DIALOGUE.options[i];
		var _thisStruct = {name: _currOption[0], func : MenuSelectDialogue, args: [_currOption[1]], avail: true};
		array_push(_options, _thisStruct);
	}
	var allHeight = optionSep * numOptions;
	var heightFull = allHeight + optionMargin * 2;
	
	Menu(textbox_X + xOffset + optionXOffset, textbox_Y + optionYOffset - heightFull, _options);
}

//Draw stuff
txt_img += txt_img_spd;
var txt_spr_W = sprite_get_width(txt_spr);
var txt_spr_H = sprite_get_height(txt_spr);

draw_sprite_ext(txt_spr, txt_img, textbox_X + xOffset, textbox_Y, textbox_width / txt_spr_W, textbox_height / txt_spr_H, 0, c_white, 1);

var _drawText = string_copy(text, 1, drawChar);
draw_text_ext_transformed(textbox_X + xOffset + margin, textbox_Y + margin, _drawText, line_sep, line_width * 2, 0.5, 0.5, 0);




