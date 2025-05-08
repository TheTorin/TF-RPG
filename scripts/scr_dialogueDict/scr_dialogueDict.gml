
//All dialogue in the game
//Each character gets a struct
//Each entry under that is a single textbox that appears
//The only required entries are text (what to write) and xOffset (-1 for left of screen, 1 for right of screen)
//Optional entries include:
//		next_dialogue : the name of the next entry to go to
//		options: options for the player to pick. A 2D array with [['option 1', entryName01] , ['option 2', entryName02] ...]
//		emotion : dictates the sprite to use
//		func : function to run AFTER clicking past text
global.dialogue = {

	Default : {
		Default : {
			text : "Well, this wasn't supposed to happen",
			next_dialogue : "Default02",
			xOffset : 1
		},
		
		Default02 : {
			text : "Looks like you stumbled onto some debug text!",
			next_dialogue : "Default03",
			xOffset : 1
		},
		
		Default03 : {
			text : "What's 'debug text', you ask?",
			next_dialogue : "Default04",
			xOffset : 1
		},
		
		Default04 : {
			text : "Oh, silly adventurers! Don't you worry about it. It's a matter for the gods to handle",
			next_dialogue : "Default05",
			xOffset : 1
		},
		
		Default05 : {
			text : "Run along, and forget you saw anything~",
			xOffset : 1
		}
	},

	Torin : {
		FirstMeet : {
			text : "Maybe something like this?",
			xOffset : 1,
			options : ["Yes", "No"],
			emotion : "nuetral"
		}
	},
	
	TestDoor : {
		Interact : {
			text : "I am a door...",
			xOffset : 1,
			next_dialogue : "Interact02",
			emotion : "nuetral"
		},
		
		Interact02 : {
			text : "My purpose is to stand here...",
			xOffset : 1,
			next_dialogue : "Interact03",
			emotion : "nuetral"
		},
		
		Interact03 : {
			text : "Until I am told to open......",
			xOffset : 1,
			options : [["Open!", "InteractOpen"], ["Okay, have fun with that!", "InteractEnd"]],
			emotion : "nuetral"
		},
		
		InteractOpen : {
			text : "I must open! aaaAAAAAA!!!",
			xOffset : 1,
			emotion : "nuetral",
			func : function() {
				instance_destroy(obj_testDoorText);	
			}
		},
		
		InteractEnd : {
			text : "I wait...",
			xOffset : 1,
			emotion : "nuetral"
		}
	}
}