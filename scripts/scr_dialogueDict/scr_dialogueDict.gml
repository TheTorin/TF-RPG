
//All dialogue in the game
//Each character gets a struct
//Each entry under that is a single textbox that appears
//The only required entries are text (what to write) and xOffset (-1 for text on the left of screen, 1 for right of screen, 0 for middle)
//Optional entries include:
//		next_dialogue : the name of the next entry to go to
//		options: options for the player to pick. A 2D array with [['option 1', entryName01] , ['option 2', entryName02] ...]
//		sprSpeaker : dictates the sprite to use
//		func : function to run AFTER clicking past text
//		textSpr : textbox sprite to use
//		textSnd : the sound to play while typing out text (the characters 'talking' sound)
//		textFX : any effects on the text. It is a struct where the key is the string to modify, and the value is an array with values [TEXT_FX.(enum val), modification]

enum TEXT_FX {
	COLOR,
	WAVE
}

global.dialogue = {

	Default : {
		Default : {
			text : "Well, this wasn't supposed to happen",
			next_dialogue : "Default02",
			xOffset : 0
		},
		
		Default02 : {
			text : "Looks like you stumbled onto some debug text!",
			next_dialogue : "Default03",
			xOffset : 0
		},
		
		Default03 : {
			text : "What's 'debug text', you ask?",
			next_dialogue : "Default04",
			xOffset : 0
		},
		
		Default04 : {
			text : "Oh, silly adventurers! Don't you worry about it. It's a matter for the gods to handle",
			next_dialogue : "Default05",
			xOffset : 0
		},
		
		Default05 : {
			text : "Run along, and forget you saw anything~",
			xOffset : 0
		}
	},

	Torin : {
		FirstMeet : {
			text : "Maybe something like this?",
			xOffset : 1,
			options : ["Yes", "No"],
		}
	},
	
	TestDoor : {
		Interact : {
			text : "I am a door...",
			xOffset : -1,
			next_dialogue : "Interact02",
			sprSpeaker : spr_unknown,
			textFX : {
				"door" : [TEXT_FX.COLOR, c_orange]
			}
		},
		
		Interact02 : {
			text : "My purpose is to stand here...",
			xOffset : 1,
			next_dialogue : "Interact03",
			sprSpeaker : spr_unknown
		},
		
		Interact03 : {
			text : "Until I am told to open......",
			xOffset : -1,
			options : [["Open!", "InteractOpen"], ["Okay, have fun with that!", "InteractEnd"]],
			sprSpeaker : spr_unknown,
			textFX : {
				"open" : [TEXT_FX.COLOR, c_yellow]
			}
		},
		
		InteractOpen : {
			text : "I must open! aaaAAAAAA!!!",
			xOffset : -1,
			sprSpeaker : spr_unknown,
			textFX : {
				"aaaAAAAAA!!!" : [TEXT_FX.WAVE, true]
			},
			func : function() {
				instance_destroy(obj_testDoorText);	
			}
		},
		
		InteractEnd : {
			text : "I wait...",
			xOffset : 0,
			sprSpeaker : spr_unknown
		}
	}
}