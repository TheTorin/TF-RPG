/// @param speaker
/// @param dialogueChain
function createTextbox(_speaker, _chain) {
	if (!instance_exists(obj_textBox)) {
		with instance_create_depth(0, 0, -9999, obj_textBox) {
			character_name = _speaker;
			current_dialogue = _chain;
			setup = false;
		}
	}
}

//
function parseFX(_text, _FXList) {
	//Init defaults
	charColor = [[500, c_white]];
	var strings = variable_struct_get_names(_FXList);
	for (var i = 0; i < array_length(strings); i++) {
		var startChar = string_pos(strings[i], _text);
		if (startChar == 0) show_error("Invalid string given during dialogue text FX search! Could not find given text string in the dialogue", true);
		var strLen = string_length(strings[i]);
		var endChar = startChar + strLen;
		//Ugly, but access the enum
		switch (_FXList[$ strings[i]][0]) {
			
			#region COLOR_FX
			case TEXT_FX.COLOR:
				//We do not assume that the FX have been placed in order. Find the proper place
				for (var c = 0; c < array_length(charColor); c++) {
					if (startChar <= charColor[c][0]) {
						if startChar == 1 or (c != 0 and startChar == charColor[c - 1][0]) {
							//same start, later placed FX takes precedence
							if (endChar == charColor[c][0]) {
								//exact overwrite, oops! Designers did a bad!
								charColor[c][1] = _FXList[$ strings[i]][1];
							}
							else if (endChar < charColor[c][0]) {
								//insert -before- found element
								array_insert(charColor, c, [endChar, _FXList[$ strings[i]][1]]);
							}
							else {
								//continues -past- this element! Now need to delete any future overriden values
								charColor[c] = [endChar, _FXList[$ strings[i]][1]];
								var u = c + 1;
								while (u < array_length(charColor) and charColor[u][0] <= charColor[c][0]) {
									array_delete(charColor, u, 1);
								}
							}
						}
						//NOT the same start. Update values as needed
						else {
							charColor[c][0] = startChar;
							c++;
							array_insert(charColor, c, [endChar, _FXList[$ strings[i]][1]]);
							//If we overwrite the 'end' value, add more buffer to the end
							if (c + 1 == array_length(charColor)) {
								array_push(charColor, [500, c_white]);
							}
							else {
								//Check to see if we've overwritten any other values. Otherwise, just move the start of the next val
								var u = c + 1;
								while (u < array_length(charColor) and charColor[u][0] <= charColor[c][0]) {
									array_delete(charColor, u, 1);
								}
							}
						}
					}
					//We found the value, no need to continue
					break;
				}
				
				break;
			#endregion COLOR_FX
			
			#region WAVE_FX
			case TEXT_FX.WAVE:
				break;
			#endregion WAVE_FX
			
			default:
				var str = string("Error, unrecognized text FX passed! {0}", _FXList[strings[i]][0]);
				show_error(str, true);
		}
	}
}