//BG Art
draw_sprite(currBattleBG,0,x,y);

//Draw all units
for (var i = 0; i < array_length(unitRenderOrder); i++) {
	with (unitRenderOrder[i]) {
		draw_self();	
	}
}

//Calculate attack speed / units ready to take their turn
for (var i = 0; i < array_length(units); i++) {
	with (units[i]) {
		if (hp > 0) {
			if (other.unitTakingTurn == false) {
				currSpeed += spd;
				if (currSpeed >= maxAtkSpd) {
					array_push(other.queuedUnits, self.id);
					//Potential lever; leftover speed carries over? Or just set to 0?
					//If someone gets enough speed, should they get two turns?
					currSpeed = 0;
				}
			}
			var currPercent = (currSpeed / maxAtkSpd) * 100;
			draw_healthbar(x, y + 3, x + 32, y, currPercent, c_black, c_white, c_white, 0, true, true);
			var percentHP = (hp / maxHp) * 100;
			draw_healthbar(x, y + 6, x + 32, y + 3, percentHP, c_black, c_green, c_green, 0, true, true);
		}
		else if (object_index == obj_BattlingPC) {
			draw_healthbar(x, y + 6, x + 32, y + 3, 100, c_black, c_red, c_red, 0, true, true);
		}
	}
}


//UI boxes
draw_sprite_stretched(spr_Box, 0, x + boxDraw[0][0], y + boxDraw[0][1], boxDraw[0][2], boxDraw[0][3]);
draw_sprite_stretched(spr_Box, 0, x + boxDraw[1][0], y + boxDraw[1][1], boxDraw[1][2], boxDraw[1][3]);

//Set vars we will need
#macro X_PADDING 30
#macro Y_PADDING 3
#macro COLUMN_PADDING 70
#macro ROW_PADDING 7

draw_set_font(DefaultFont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_dkgray);

var baseEnemyX = x + boxDraw[1][0] + X_PADDING
var baseEnemyY = y + boxDraw[1][1] + Y_PADDING
var basePCX = x + boxDraw[0][0] + X_PADDING
var basePCY = y + boxDraw[0][1] + Y_PADDING

//Only draw UI and such if battle is ongoing
if (!endScreen) {
	//Headers
	draw_text_transformed(baseEnemyX, baseEnemyY, "ENEMY", 0.3, 0.3, 0);
	draw_text_transformed(basePCX, basePCY, "NAME", 0.3, 0.3, 0);
	draw_text_transformed(basePCX + COLUMN_PADDING, basePCY, "HP", 0.3, 0.3, 0);
	draw_text_transformed(basePCX + (COLUMN_PADDING * 2), basePCY, "MP", 0.3, 0.3, 0);

	draw_set_halign(fa_center);

	baseEnemyY -= 2;
	//Enemy list UI
	var _drawLimit = 4;
	var _drawn = 0;
	draw_set_colour(c_white);
	for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++) {
		var _char = enemyUnits[i];
		if (_char.hp > 0) {
			_drawn++;
			if (unitTakingTurn && (currUnitTurn != noone) && (currUnitTurn == _char.id)) {
				draw_set_colour(c_teal);
				draw_text_transformed(baseEnemyX, baseEnemyY + ((i + 1) * ROW_PADDING), _char.name, 0.5, 0.5, 0);
				draw_set_colour(c_white);
			}
			else {
				draw_text_transformed(baseEnemyX, baseEnemyY + ((i + 1) * ROW_PADDING), _char.name, 0.5, 0.5, 0);
			}
		}
	}

	//Party info UI
	basePCY -= 2;
	for (var i = 0; i < array_length(partyUnits); i++) {
		var _char = partyUnits[i];
	
		if (unitTakingTurn && (currUnitTurn != noone) && (currUnitTurn == _char.id)) draw_set_colour(c_teal);
		else if (_char.hp <= 0) draw_set_colour(c_red);
		else draw_set_colour(c_white);
	
		draw_text_transformed(basePCX, basePCY + ((i + 1) * ROW_PADDING),_char.name, 0.5, 0.5, 0);
	
		draw_set_colour(c_green);
		draw_text_transformed(basePCX + COLUMN_PADDING, basePCY + ((i + 1) * ROW_PADDING), string(_char.hp) + "/" + string(_char.maxHp), 0.5, 0.5, 0);
	
		draw_set_colour(c_teal);
		draw_text_transformed(basePCX + (COLUMN_PADDING * 2), basePCY + ((i + 1) * ROW_PADDING), string(_char.mana) + "/" + string(_char.maxMana), 0.5, 0.5, 0);
	}

	if (cursor.active) {
		with (cursor) {
			if (activeTarget != noone) {
				if (!is_array(activeTarget)) {
					draw_sprite(spr_pointer, frame, activeTarget.x, activeTarget.y);
				}
				else {
					for (var i = 0; i < array_length(activeTarget); i++) {
						draw_sprite(spr_pointer, frame, activeTarget[i].x, activeTarget[i].y);	
					}
				}
			}
		}
	}
	
	if (battleText != "") {
		var _w = string_width(battleText) + 20;
		draw_sprite_stretched(spr_Box, 0, x + 160 - (_w * 0.25), y + 5, _w * 0.5, 20);
		draw_set_halign(fa_center);
		draw_set_color(c_white);
		draw_text_transformed(x + 160, y + 10, battleText, 0.5, 0.5, 0);
	}
}
else if (victory) {
	draw_text_transformed(basePCX + COLUMN_PADDING, basePCY + ROW_PADDING, "Victory! You win!", 0.5, 0.5, 0);	
}
else {
	draw_text_transformed(basePCX + COLUMN_PADDING, basePCY + ROW_PADDING, "The party wiped out...", 0.5, 0.5, 0);
}