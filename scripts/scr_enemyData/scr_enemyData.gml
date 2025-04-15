//Enemy data

global.enemies = 
{
	wolf:
	{
		name: "Raging Wolf",
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
		xpVal: 1,
		sprites:
		{
			Idle: anim_wolfIdle,
			Attack: anim_wolfAttack
		},
		actions: [],
		AI : function()
		{
			
		}
	}
}