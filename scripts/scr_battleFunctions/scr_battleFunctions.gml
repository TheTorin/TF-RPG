function NewEncounter(_enemies, _bg)
{
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-999,
		MGR_Battle,
		{
			enemies: _enemies,
			creator: id,
			currBattleBG: _bg
		}
	);
}

//Later on, add Observer pattern for these instances so that items can react to these
//Need to create inventory/per-character equipment first
function OnDodge(_unit)
{
	
}

function OnBlock(_unit)
{
	
}

function BattleChangeHP(_unit, _amount, _AliveOrDeadOrEither = 0)
{
	var failed = false;
	if (_AliveOrDeadOrEither == 0) && (_unit.hp <= 0) failed = true;
	if (_AliveOrDeadOrEither == 1) && (_unit.hp > 0) failed = true;
	
	var _col = c_white;
	if (_amount > 0) _col = c_lime;
	if (_amount < -10) _col = c_red;
	
	if (failed) {
		_col = c_white;
		_amount = "failed";
	}
	
	instance_create_depth(
		_unit.x,
		_unit.y,
		_unit.depth - 1,
		obj_BattleText,
		{font: DefaultFont, col: _col, text: string(_amount)}
	);
	if (!failed) _unit.hp = clamp(_unit.hp + _amount, 0, _unit.maxHp);
}