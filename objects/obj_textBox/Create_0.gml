depth = -9999;

//Default values
textbox_width = 191;
textbox_height = 52;
xShift = 44;
textbox_X = 0;
textbox_Y = 0;
margin = 6;
line_sep = 18;
line_width = textbox_width - margin * 2;

//text sprite vars
txt_spr = spr_Box;
txt_img = 0;
txt_img_spd = 0;

//text vars
character_name = "Default";
current_dialogue = "Default";

#macro TXT_NAME global.dialogue[$ character_name]
#macro TXT_CURR_DIALOGUE global.dialogue[$ character_name][$ current_dialogue]

xOffset = 0;
text = TXT_CURR_DIALOGUE.text;
textLen = string_length(text);
drawChar = 0;
textSpeed = 1;

//options vars
optionXOffset = 0;
optionYOffset = 1;
optionSep = 10;
optionMargin = 6;

setup = false;

function nextDialogue() {
	if (variable_struct_exists(TXT_CURR_DIALOGUE, "func")) {
		TXT_CURR_DIALOGUE.func();
	}
	
	if (variable_struct_exists(TXT_CURR_DIALOGUE, "next_dialogue")) {
		current_dialogue = TXT_CURR_DIALOGUE.next_dialogue;
		drawChar = 0;
		text = TXT_CURR_DIALOGUE.text;
		textLen = string_length(text);
	}
	else {
		instance_destroy();	
	}
}

function makeChoice(_branch) {
	if (variable_struct_exists(TXT_CURR_DIALOGUE, "func")) {
		TXT_CURR_DIALOGUE.func();
	}
	
	current_dialogue = _branch;
	drawChar = 0;
	text = TXT_CURR_DIALOGUE.text;
	textLen = string_length(text);
}