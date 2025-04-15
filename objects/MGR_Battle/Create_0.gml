//Reminder: atkSpd is incremented every frame.
//At 60fps, an atkSpd of 1 will reach 180 in 3 seconds.
#macro maxAtkSpd 180.0

instance_deactivate_all(true);

units = [];
turn = 0;
unitTakingTurn = false;
currUnitTurn = pointer_null;
queuedUnits = [];
unitRenderOrder = [];

var placement = getEnemyPlacement(currBattleBG, array_length(enemies));

//Initialize enemies
for (var i = 0; i < array_length(enemies); i++) {
	enemyUnits[i] = instance_create_depth(placement[i][0], placement[i][1], depth-10, obj_BattlingEnemy, enemies[i]);
	array_push(units, enemyUnits[i]);
}

//Now players
placement = getPlayerPlacement(currBattleBG);

for (var i = 0; i < array_length(global.party); i++) {
	partyUnits[i] = instance_create_depth(placement[i][0], placement[i][1], depth-10, obj_BattlingPC, global.party[i]);
	array_push(units, partyUnits[i]);
}

boxDraw = getBoxPlacement(currBattleBG);

RefreshRenderOrder = function() {
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder, function(_1, _2) {
		return _1.y - _2.y;	
	});
}
RefreshRenderOrder();