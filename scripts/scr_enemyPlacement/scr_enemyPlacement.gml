//Returns nested array [[x,y][x,y]...]
function getEnemyPlacement(_bg, _numEnemies) {
	switch(_bg) {
		case spr_TestBG:
			return getTestBGEnemyPlacement(_numEnemies);
		
		default:
			return errorPlacement(_numEnemies);
	}
}

function getTestBGEnemyPlacement(_numEnemies) {
	switch(_numEnemies) {
		case 1:
			return [[210, 110]];
		case 2:
			return [[225, 20],[250, 50]];
		default:
			return 0
	}
}

function errorPlacement(_numEnemies) {
	var ret = [];
	for (var i = 0; i < _numEnemies; i++) {
			array_push(ret, [100 + (i*10), 100 + i*10]);
	}
	return ret;
}