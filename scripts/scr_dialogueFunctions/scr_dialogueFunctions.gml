/// @param text, 
function scriptText(_text) {
	text[pageNum] = _text;
	pageNum++;
}

/// @param speaker
/// @param dialogueChain
function createTextbox(_speaker, _chain) {
	if (!instance_exists(obj_textBox)) {
		with instance_create_depth(0, 0, -9999, obj_textBox) {
			character_name = _speaker;
			current_dialogue = _chain;
		}
	}
}