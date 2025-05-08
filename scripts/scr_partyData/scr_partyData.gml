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
		wis: 1,
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
		affinity: {
			human : 5,
			reptile : 0,
			avian : 0,
			aquatic : 0,
			beast : 0,
			smallCreature : 0,
			liveArmor : 0,
			elemental : 0
		},
		sprites: {
			//Sprite names should be capitalized to match sprite asset names... for reasons ;w;
			Idle: pointer_null,
			Attack: charOneAttack
		},
		actions: [global.actionLibrary.attack]
	}
	,
	{
		name: "CharTwo",
		hp: 10,
		maxHp: 10,
		str: 5,
		def: 1,
		spd: 2,
		luck: 1,
		dodge: 1,
		block: 1,
		wis: 10,
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
		affinity: {
			human : 5,
			reptile : 0,
			avian : 0,
			aquatic : 0,
			beast : 0,
			smallCreature : 0,
			liveArmor : 0,
			elemental : 0
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: [global.actionLibrary.attack, global.actionLibrary.fireball]
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
		wis: 1,
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
		affinity: {
			human : 5,
			reptile : 0,
			avian : 0,
			aquatic : 0,
			beast : 0,
			smallCreature : 0,
			liveArmor : 0,
			elemental : 0
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: [global.actionLibrary.attack]
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
		wis: 1,
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
		affinity: {
			human : 5,
			reptile : 0,
			avian : 0,
			aquatic : 0,
			beast : 0,
			smallCreature : 0,
			liveArmor : 0,
			elemental : 0
		},
		sprites: {
			Idle: charOneIdle,
			Attack: charOneAttack
		},
		actions: [global.actionLibrary.attack]
	}
]