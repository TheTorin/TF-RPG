//BG Art
draw_sprite(currBattleBG,0,x,y);

//Draw all units
for (var i = 0; i < array_length(unitRenderOrder); i++) {
	with (unitRenderOrder[i]) {
		draw_self();	
	}
}

if unitTakingTurn {
	unitTakingTurn = false;
	currUnitTurn = pointer_null;
}
//Calculate attack speed / units ready to take their turn
for (var i = 0; i < array_length(units); i++) {
	with (units[i]) {
			currSpeed += spd;
			if (currSpeed >= maxAtkSpd) {
				array_push(other.queuedUnits, self);
				//Potential lever; leftover speed carries over? Or just set to 0?
				//If someone gets enough speed, should they get two turns?
				currSpeed = 0;
			}
			var currPercent = (currSpeed / maxAtkSpd) * 100;
			draw_healthbar(x, y + 3, x + 32, y, currPercent, c_black, c_white, c_white, 0, true, true);
			var percentHP = (hp / maxHp) * 100;
			draw_healthbar(x, y + 6, x + 32, y + 3, percentHP, c_black, c_green, c_green, 0, true, true);
	}
}

//UI boxes
draw_sprite_stretched(spr_combatBox, 0, x + boxDraw[0][0], y + boxDraw[0][1], boxDraw[0][2], boxDraw[0][3]);
draw_sprite_stretched(spr_combatBox, 0, x + boxDraw[1][0], y + boxDraw[1][1], boxDraw[1][2], boxDraw[1][3]);