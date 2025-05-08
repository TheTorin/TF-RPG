battleState();

if (cursor.active) {
	with (cursor) {
		
		frameDelay++;
		if (frameDelay > 30) {
			frameDelay = 0;
			frame = !frame;
		}
		
		var _moveH = input_check_pressed("right") - input_check_pressed("left");
		var _moveV = input_check_pressed("down") - input_check_pressed("up");
		var _keyToggle = false;
		var _keyConfirm = false;
		var _keyCancel = false;
		
		confirmDelay++;
		if (confirmDelay > 4) {
			_keyToggle = input_check_pressed("special");
			_keyCancel = input_check_pressed("pause") or input_check_pressed("cancel");
			_keyConfirm = input_check_pressed("accept") or input_check_pressed("action");
		}
		
		if (activeAction.allowSideSwap) {
			if (_moveH == -1) targetSide = MGR_Battle.partyUnits;
			if (_moveH == 1) targetSide = MGR_Battle.enemyUnits
		}
		
		if (targetSide == MGR_Battle.enemyUnits) {
			targetSide = array_filter(targetSide, function(_element, _index) {
				return _element.hp > 0;	
			});
		}
		
		if (targetAll == false) {
			if (_moveV == 1) targetIndex++;
			if (_moveV == -1) targetIndex --;
			
			//wrap
			var _targets = array_length(targetSide);
			if (targetIndex < 0) targetIndex = _targets - 1;
			if (targetIndex > (_targets - 1)) targetIndex = 0;
			
			//target
			activeTarget = targetSide[targetIndex];
			
			if (activeAction.targetAll == MODE.VARIES) and (_keyToggle) {
				targetAll = true;	
			}
		}
		else {
			activeTarget = targetSide;
			if (activeAction.targetAll == MODE.VARIES) and (_keyToggle) {
				targetAll = false;	
			}
		}
		
		//Confirm?
		if (_keyConfirm) {
			with (MGR_Battle) BeginAction(cursor.activeTarget, cursor.activeAction, cursor.activeTarget);
			with (obj_Menu) instance_destroy();
			active = false;
			confirmDelay = 0;
		}
		else if (_keyCancel) {
			with (obj_Menu) active = true;
			active = false;
			confirmDelay = 0;
		}
	}
}