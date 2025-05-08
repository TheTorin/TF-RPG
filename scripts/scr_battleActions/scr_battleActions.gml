//All actions that can be performed by any unit, to reference by scripts and such

//All structs should follow this setup. The fields are required unless otherwise noted:
// internalName : {
//		name : "Test" (display name to show player. Short and simple!)
//		description : "{0} does a test to {1}!" (string to show when action done. {0} for user, {1} for target
//		subMenu : -1	(If the action is in a submenu i.e Magic, put that string here. Otherwise, -1
//		targetRequired : true	(does it need a selected target? Or auto-cast i.e heal all party members?)
//		targetEnemyByDefault : true	(should select cursor appear over enemies first, or players?)
//		targetAll : MODE.NEVER	(can this hit everyone on a side? All players/all enemies?)
//		allowSideSwap : MODE.NEVER (can the targeting switch from enemies to players, or vice-versa?)
//		func : function(_user, _targets) {
//			yadda yadda
//		}	(What does the spell do? We always pass _user and _targets. Targets is an array)
//
//		[OPTIONAL] userAnimation : "Test" (the name of the animation to play during the cast)
//		[OPTIONAL] effectSprite : spr_Test (sprite to play on targets when action is used)
//		[OPTIONAL] effectSpriteNoTarget : false (False for screen-wide effects or big AOEs, true for individual FX)
//		[OPTIONAL] mpCost : 1	(How much mana it costs to use)

enum MODE {
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2
}

#macro MAX_LUCK 10
#macro LUCK_CRIT 9.5
#macro CRIT_MOD 3
#macro DMG_VARIANCE 0.25

global.actionLibrary = {
	attack : {
		name : "Attack",
		description : "{0} attacks {1}!",
		subMenu : -1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		allowSideSwap : MODE.NEVER,
		userAnimation : "Attack",
		func : function(_user, _targets) {
			var damage = 0;
			var hitLuck = random(MAX_LUCK) + _user.luck;
			var dodgeLuck = random(MAX_LUCK) + _targets[0].dodge;
			if (hitLuck > LUCK_CRIT) {
				damage = _user.str * CRIT_MOD;
			}
			else {
				hitLuck += 10;
				if (hitLuck >= dodgeLuck) {
					damage = ceil(_user.str + random_range(-_user.str * DMG_VARIANCE, _user.str * DMG_VARIANCE) - _targets[0].def);
					if (damage < 0) {
						damage = 0;
						OnBlock(_targets[0]);
					}
				}
				else OnDodge(_targets[0]);
			}
			BattleChangeHP(_targets[0], damage * -1);
		}
	},
	fireball : {
		name : "Fireball",
		description : "{0} casts Fireball!",
		subMenu : "Magic",
		mpCost : 1,
		targetRequired : true,
		targetEnemyByDefault : true,
		targetAll : MODE.NEVER,
		allowSideSwap : MODE.NEVER,
		userAnimation : "Attack",
		func : function(_user, _targets) {
			_user.mana -= mpCost;
			var damage = 0;
			var hitLuck = random(MAX_LUCK) + _user.luck * 5;
			var dodgeLuck = random(MAX_LUCK) + _targets[0].dodge;
			if (hitLuck > LUCK_CRIT) {
				damage = _user.wis * CRIT_MOD;
			}
			else {
				if (hitLuck >= dodgeLuck) {
					damage = _user.wis * 20 - _targets[0].def;
					if (damage < 0) {
						damage = 0;
						OnBlock(_targets[0]);
					}
				}
				else OnDodge(_targets[0]);
			}
			BattleChangeHP(_targets[0], damage * -1);
		}
	}
}