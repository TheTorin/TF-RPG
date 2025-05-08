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
		wis: 1,
		mana: 1,
		maxMana: 1,
		xpVal: 1,
		sprites:
		{
			Idle: anim_wolfIdle,
			Attack: anim_wolfAttack
		},
		actions: [global.actionLibrary.attack],
		AI : function()
		{
			//Choose random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(MGR_Battle.partyUnits, function(_unit, _index) {
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];
			return [_action, _target];
		}
	}
}