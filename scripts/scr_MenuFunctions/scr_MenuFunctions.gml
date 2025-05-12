//Create a menu at the given position
//Options is an array of structs, each element being [{name, func, args, avail}]
function Menu(_x, _y, _options, _description = -1, _width = undefined, _height = undefined){
	with (instance_create_depth(_x, _y, -99999, obj_Menu)) {
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//size
		xMargin = 10;
		yMargin = 8;
		draw_set_font(DefaultFont);
		heightLine = 8;
		
		//width
		if (_width == undefined) {
			width = 1;
			if (description != -1) width = max(width, string_width(description));
			for (var i = 0; i < _optionsCount; i++) {
				width = max(width, string_width(_options[i].name));
			}
			width *= 0.5;
			widthFull = width + xMargin * 2;
		} 
		else widthFull = _width;
		
		//height
		allHeight = heightLine * (_optionsCount + (description != -1));
		if (_height == undefined) {
			heightFull = allHeight + yMargin * 2;
		}
		else {
			heightFull = _height;
			//Check scrolling
			boxHeight = _height - (yMargin * 2);
			if (allHeight > boxHeight) {
				scrolling = true;
				visibleOptionsMax = boxHeight div heightLine
			}
		}
	}
}

function SubMenu(_options)
{
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel]
	hover = 0;
}

function MenuSelectAction(_user, _action)
{
	with(obj_Menu) active = false;
	
	with(MGR_Battle) {
		if (_action.targetRequired) {
			with (cursor) {
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser = _user;
						
				if (_action.targetEnemyByDefault) {
					targetIndex = 0;
					targetSide = MGR_Battle.enemyUnits;
					activeTarget = MGR_Battle.enemyUnits[targetIndex];
				}
				else {
					targetSide = MGR_Battle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element) {
						return (_element == activeTarget);	
					}
					targetIndex = array_find_index(MGR_Battle.partyUnits, _findSelf);
				}
			}
		}
		else {
			BeginAction(_user, _action, -1);
			with (obj_Menu) instance_destroy();
		}
	}
}

function MenuSelectDialogue(_nextDialogue) {
	with (obj_Menu) active = false;

	with (obj_textBox) {
		makeChoice(_nextDialogue);
		with (obj_Menu) instance_destroy();
	}
}