//Reminder: atkSpd is incremented every frame.
//At 60fps, an atkSpd of 1 will reach 180 in 3 seconds.
#macro maxAtkSpd 180.0
#macro MENU_OFFSET 10

instance_deactivate_all(true);
instance_activate_object(input_controller_object);

units = [];
turn = 0;
unitTakingTurn = false;
currUnitTurn = noone;
queuedUnits = [];
unitRenderOrder = [];
endScreen = false;
victory = false;

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
currentUser = noone;
currentAction = -1;
currentTargets = noone;

cursor = 
{
	activeUser : noone,
	activeTarget : noone,
	activeAction : -1,
	targetSide : -1,
	targetIndex : 0,
	targetAll : false,
	confirmDelay : 0,
	active : false,
	frame : false,
	frameDelay : 0
}

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



#region BATTLE_STATE_MACHINE
//STATE MACHINE
function BattleStateSelectAction() {
	if (!instance_exists(obj_Menu)) {
		var _unit = currUnitTurn;
	
		if (!instance_exists(_unit) || (_unit.hp <= 0)) {
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		if (_unit.object_index == obj_BattlingPC) {
			//Create menu to prompt player for action!
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			//Go through actions, add to menu and create submenus as needed
			for (var i = 0; i < array_length(_actionList); i++) {
				var _action = _actionList[i];
				var _available = true;
				if (variable_struct_exists(_action, "mpCost")) {
						if (_action.mpCost > _unit.mana) _available = false;
				}
				var _nameAndCount = _action.name //TODO: change later to allow for items as actions
				
				var _optionStruct = {name : _nameAndCount, func : MenuSelectAction, args : [_unit, _action], avail : _available};
				if (_action.subMenu == -1) {
					array_push(_menuOptions, _optionStruct);	
				}
				//Create submenu or add to existing one
				else {
					if (is_undefined(_subMenus[$ _action.subMenu])) variable_struct_set(_subMenus, _action.subMenu, [_optionStruct]);
					else array_push(_subMenus[$ _action.subMenu], _optionStruct);
				}
			}
			
			//Add in submenu ("Magic", "Items", e.t.c)
			var _subMenuArray = variable_struct_get_names(_subMenus);
			for (var i = 0; i < array_length(_subMenuArray); i++) {
				//Sort menus here if needed?
				array_push(_subMenus[$ _subMenuArray[i]], {name : "Back", func : MenuGoBack, args : undefined, avail : true});
				array_push(_menuOptions, {name : _subMenuArray[i], func : SubMenu, args : [_subMenus[$ _subMenuArray[i]]], avail : true});
			}
			//Create menu!
			Menu(boxDraw[1][0] + MENU_OFFSET, boxDraw[1][1] - MENU_OFFSET, _menuOptions, , boxDraw[1][2], boxDraw[1][3]);
		}
		//Enemy AI
		else {
			var _enemyAction = _unit.AI();
			if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
		}
	}
}

function BeginAction(_user, _action, _targets) {
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	
	with(_user) {
		acting = true;
		if (variable_struct_exists(_action, "userAnimation") && variable_struct_exists(_user.sprites, _action.userAnimation)) {
			sprite_index = sprites[$ _action.userAnimation];
			image_index = 0;
		}
	}
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction() {
	if (currentUser.acting) {
		if (currentUser.image_index >= currentUser.image_number - 1) {
			with (currentUser) {
				sprite_index = sprites.Idle;
				image_index = 0;
				acting = false;
			}
		
			if (variable_struct_exists(currentAction, "effectSprite")) {
				if ((currentAction.effectOnTarget == MODE.ALWAYS) || ((currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1))) {
					for (var i = 0; i < array_length(currentTargets); i++) {
						instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth - 1, obj_BattleFX, {sprite_index : currentAction.effectSprite});
					}
				}
				else {
					var _effectSprite = currentAction.effectSprite;
					if (variable_struct_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
					instance_create_depth(x, y, depth - 100, obj_BattleFX, {sprite_index : _effectSprite});
				}
			}
			currentAction.func(currentUser, currentTargets);
		}
	}
	//Wait for minimum time before ending action
	else {
		if (!instance_exists(obj_BattleFX)) {
			battleWaitTimeRemaining--;
			if (battleWaitTimeRemaining <= 0) {
				battleState = BattleStateVictoryCheck;	
			}
		}
	}
}

function BattleStateVictoryCheck() {
	if (!endScreen) {
		//Did players win?
		var _unitsDead = true;
		for (var i = 0; i < array_length(enemyUnits); i++) {
			if (enemyUnits[i].hp > 0) {
				_unitsDead = false;
				break;
			}
		}
		if (_unitsDead) {
			//Victory screech!
			endScreen = true;
			victory = true;
		
		}
	
		//Did enemies win?
		_unitsDead = true;
		for (var i = 0; i < array_length(partyUnits); i++) {
			if (partyUnits[i].hp > 0) {
				_unitsDead = false;
				break;
			}
		}
		if (_unitsDead) {
			//Whomp whomp
			//add logic for loading from last save?
			endScreen = true;
		}
		//extra check
		if (!endScreen) battleState = BattleStateTurnProgression;
	}
	else if (keyboard_check_pressed(vk_anykey)) {
		instance_activate_all();
		if (victory) instance_destroy(creator);
		instance_destroy();
	}
}

function BattleStateTurnProgression() {
	turnCount++;
	battleState = BattleStateWaitForTurn;
}

function BattleStateWaitForTurn() {
	if (array_length(queuedUnits) > 0) {
		unitTakingTurn = true;
		currUnitTurn = array_shift(queuedUnits);
		battleState = BattleStateSelectAction;
	}
	else {
		unitTakingTurn = false;
		currUnitTurn = noone;
	}
}

battleState = BattleStateWaitForTurn;
#endregion BATTLE_STATE_MACHINE