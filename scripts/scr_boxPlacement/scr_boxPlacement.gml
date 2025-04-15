//Return fixed placement. If party is missing characters, then it will highlight their absence
function getBoxPlacement(_bg) {
	switch(_bg) {
		case spr_TestBG:
			return [[75, 120, 213, 42], [0, 120, 74, 42]]
		default:
			return [[10, 10, 50, 150], [20, 20, 150, 50]]
	}
}