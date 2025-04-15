//Initialize with base stats
enum AGE {
	Child,
	Young,
	Middle,
	Old
}

enum SEX {
	Male,
	Female,
	Herm
}

global.party = [
	{
		name: "CharOne",
		hp: 10,
		maxHp: 10,
		str: 1,
		def: 1,
		spd: 1,
		luck: 1,
		dodge: 1,
		block: 1,
		stamina: 1,
		mana: 1,
		maxMana: 1,
		tfs: {
			head: "Human",
			chest: "Human",
			LArm: "Human",
			RArm: "Human",
			LLeg: "Human",
			RLeg: "Human",
			size: 5.0,
			age: AGE.Middle
		},
		sprites: {
			//Sprite names should be capitalized to match sprite asset names... for reasons ;w;
			Idle: pointer_null,
			Attack: charOneAttack
		},
		actions: []
	}
	,
	{
		name: "CharTwo",
		hp: 10,
		maxHp: 10,
		str: 1,
		def: 1,
		spd: 2,
		luck: 1,
		dodge: 1,
		block: 1,
		stamina: 1,
		mana: 1,
		maxMana: 1,
		tfs: {
			head: "Human",
			chest: "Human",
			LArm: "Human",
			RArm: "Human",
			LLeg: "Human",
			RLeg: "Human",
			size: 5.0,
			age: AGE.Middle
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: []
	}
	,
	{
		name: "CharThree",
		hp: 10,
		maxHp: 10,
		str: 1,
		def: 1,
		spd: 1,
		luck: 1,
		dodge: 1,
		block: 1,
		stamina: 1,
		mana: 1,
		maxMana: 1,
		tfs: {
			head: "Human",
			chest: "Human",
			LArm: "Human",
			RArm: "Human",
			LLeg: "Human",
			RLeg: "Human",
			size: 5.0,
			age: AGE.Middle
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: []
	}
	,
	{
		name: "CharFour",
		hp: 10,
		maxHp: 10,
		str: 1,
		def: 1,
		spd: 1,
		luck: 1,
		dodge: 1,
		block: 1,
		stamina: 1,
		mana: 1,
		maxMana: 1,
		tfs: {
			head: "Human",
			chest: "Human",
			LArm: "Human",
			RArm: "Human",
			LLeg: "Human",
			RLeg: "Human",
			size: 5.0,
			age: AGE.Middle
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: []
	}
]