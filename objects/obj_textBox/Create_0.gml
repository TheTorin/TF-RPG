depth = -9999;
sprite_index = noone;

//NOTE: We are currently scaling down sprites from 64x64 to 52x52
//Discuss if we want to go for 64x64 and increase heights of textboxes,
//	or if we want to go down to 52x52 size sprites
//Default values
textbox_width = 191;
textbox_height = 52;
xShift = 40;
baseTxtX = 48;
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
#macro TXT_SPR_SPD 4

//text and box vars
xOffset = 0;
text = TXT_CURR_DIALOGUE.text;
textLen = string_length(text);
drawChar = 0;
textSpeed = 1;

//sprite vars
prevSpeaker = noone;
sprSpeaker = noone;
speakerBaseX = 116;
speakerXOffset = 100;
speakerYOffset = 0;
speakerX = 0;
updateSpkrSpr = false;
speakerSideLen = 52;

//tracking chars for vfx
char[0] = "";
char_x[0] = 0;
char_y[0] = 0;
lastFreeSpace = 0;

lineBreakPos[0] = 999;
lineBreakNum = 0;
lineBreakOffset = 0;

//options vars
optionXOffset = 30;
optionYOffset = 1;
optionSep = 10;
optionMargin = 6;

//Typing/input delay and sounds
textPauseTimer = 0;
textPauseMax = 16;
inputDelay = 0;
inputDelayMax = 4;
sndFX = noone;
sndDelay = 4;
sndCount = sndDelay;

//Character specific FX (color, shake, e.t.c)
charColor = [500, c_white];
currColorInd = 0;

setup = false;

function initPage() {
	lineBreakPos = [];
	lineBreakPos[0] = 999;
	char = [];
	char_x = [];
	char_y = [];
	lastFreeSpace = 0;
	lineBreakNum = 0;
	lineBreakOffset = 0;
	
	inputDelay = inputDelayMax;
	drawChar = 0;
	text = TXT_CURR_DIALOGUE.text;
	xOffset = xShift * TXT_CURR_DIALOGUE.xOffset;
	textLen = string_length(text);	
	
	//check optional values from dictionaryDict
	//textbox sprite
	if variable_struct_exists(TXT_CURR_DIALOGUE, "textSpr") txtSpr = TXT_CURR_DIALOGUE.textSpr;
	else txtSpr = spr_Box;
	
	//speaker sprite
	if variable_struct_exists(TXT_CURR_DIALOGUE, "sprSpeaker") {
		prevSpeaker = sprSpeaker;
		if (prevSpeaker != TXT_CURR_DIALOGUE.sprSpeaker) {
			sprSpeaker = TXT_CURR_DIALOGUE.sprSpeaker;
			updateSpkrSpr = true;
		}
	}
	else sprSpeaker = noone;
	
	//typing sound fx
	if variable_struct_exists(TXT_CURR_DIALOGUE, "textSnd") sndFX = TXT_CURR_DIALOGUE.textSnd;
	else sndFX = noone;
	
	//text FX check
	if variable_struct_exists(TXT_CURR_DIALOGUE, "textFX") parseFX(text, TXT_CURR_DIALOGUE.textFX);
	else {
		//defaults
		charColor = [[500, c_white]];
	}
	
	for (var c = 0; c < textLen; c++) {
		var _charPos = c + 1;
		char[c] = string_char_at(text, _charPos);
		
		var _txtToChar = string_copy(text, 1, _charPos);
		var _currW = string_width(_txtToChar) - string_width(char[c]);
		_currW *= 0.5;
		
		if (char[c] == " ") lastFreeSpace = _charPos + 1;
		
		if (_currW - lineBreakOffset > line_width) {
			lineBreakPos[lineBreakNum] = lastFreeSpace;
			lineBreakNum++;
			var _txtToSpace = string_copy(text, 1, lastFreeSpace);
			var _lastString = string_char_at(text, lastFreeSpace);
			lineBreakOffset = (string_width(_txtToSpace) - string_width(_lastString)) * 0.5;
		}
	}
	
	//Look into optimizing this maybe? Need to place characters before finding their positions though
	for (var c = 0; c < textLen; c++) {
		var _charPos = c + 1;
		var _txtX = textbox_X + xOffset + margin;
		var _txtY = textbox_Y + margin;
		
		var _txtToChar = string_copy(text, 1, _charPos);
		var _currW = string_width(_txtToChar) - string_width(char[c]);
		_currW *= 0.5;
		var _txtLine = 0;
		
		for (var i = 0; i < lineBreakNum; i++) {
			if (_charPos >= lineBreakPos[i]) {
				var _currLine = string_copy(text, lineBreakPos[i], _charPos - lineBreakPos[i]);
				_currW = string_width(_currLine);
				_currW *= 0.5;
				_txtLine = i + 1;
			}
		}
		
		char_x[c] = _txtX + _currW;
		char_y[c] = _txtY + (line_sep * _txtLine);
	}
}

function nextDialogue() {
	if (variable_struct_exists(TXT_CURR_DIALOGUE, "func")) {
		TXT_CURR_DIALOGUE.func();
	}
	
	if (variable_struct_exists(TXT_CURR_DIALOGUE, "next_dialogue")) {
		current_dialogue = TXT_CURR_DIALOGUE.next_dialogue;
		initPage();
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
	initPage();
}