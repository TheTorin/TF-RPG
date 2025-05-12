var advanceKey = input_check_pressed("accept") or input_check_pressed("action") or input_check_pressed("shoot");

textbox_X = camera_get_view_x(view_camera[0]) + baseTxtX;
textbox_Y = camera_get_view_y(view_camera[0]) + 103;

draw_set_font(DefaultFont);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);

if (!setup) {
	setup = true;
	initPage();
}

//Skip / flip page, respecting input delay to prevent accidentally spamming through
if advanceKey and inputDelay <= 0 and (!instance_exists(obj_Menu)){
	if drawChar == textLen {
		nextDialogue();
	}
	else {
		drawChar = textLen;
	}
	inputDelay = inputDelayMax;
}
inputDelay--;
inputDelay = clamp(inputDelay, 0, inputDelayMax);

//Tracking currently drawn text
if textPauseTimer <= 0 {
	if (drawChar < textLen) {
		drawChar += textSpeed;
		drawChar = clamp(drawChar, 0, textLen);
		
		var checkChar = string_char_at(text, drawChar);
		if (checkChar == ".") {
			textPauseTimer = textPauseMax;	
		}
		else if (checkChar == "," || checkChar == "?" || checkChar == "!") {
			textPauseTimer = textPauseMax / 2;
		}
		else if (sndFX != noone) {
			if (sndCount < sndDelay) sndCount++;
			else {
				sndCount = 0;
				//if (!audio_is_playing(sndFX) {
				audio_play_sound(sndFX, 9, false);
			}
		}
	}
}
else textPauseTimer--;

//Menu and option handling
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

if (xOffset != 0 and sprSpeaker != noone) {
	//Updating sprite if needed
	if (updateSpkrSpr) {
		//Important: This should stop memory leaks?
		if (sprite_index != noone) {
			sprite_flush(sprite_index);
			sprite_delete(sprite_index);
		}
		var surf = surface_create(speakerSideLen, speakerSideLen);
		surface_set_target(surf);
		
		draw_sprite_ext(sprSpeaker, 0, 0, 0, speakerSideLen / 64, speakerSideLen / 64, 0, c_white, 1);
		var spr = sprite_create_from_surface(surf, 0, 0, speakerSideLen, speakerSideLen, true, false, 0, 0);
		sprite_set_speed(spr, TXT_SPR_SPD, spritespeed_framespersecond);
		sprite_index = spr;
		
		surface_reset_target();
		surface_free(surf);
	}
	
	//Stop anim if done 'talking'
	if (drawChar == textLen) image_index = 0;
	
	speakerX = speakerBaseX + (speakerXOffset * TXT_CURR_DIALOGUE.xOffset * -1);
	draw_sprite_ext(txt_spr, txt_img, speakerX, textbox_Y + speakerYOffset, speakerSideLen / txt_spr_W, speakerSideLen / txt_spr_H, 0, c_white, 1);
	if (TXT_CURR_DIALOGUE.xOffset == -1) speakerX += speakerSideLen;
	draw_sprite_ext(sprite_index, image_index, speakerX, textbox_Y + speakerYOffset, TXT_CURR_DIALOGUE.xOffset, 1, 0, c_white, 1);
}

currColorInd = 0;
draw_set_color(charColor[0][1]);
for (var c = 0; c < drawChar; c++) {
	if (c + 1 >= charColor[currColorInd][0]) {
		currColorInd++;
		draw_set_color(charColor[currColorInd][1]);
	}
	draw_text_transformed(char_x[c], char_y[c], char[c], 0.5, 0.5, 0);
}



