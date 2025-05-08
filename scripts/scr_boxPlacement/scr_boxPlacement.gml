//Return fixed placement. [right box][left box]
//[x, y, w, h]
function getBoxPlacement(_bg) {
	switch(_bg) {
		case spr_TestBG:
			return [[75, 120, 213, 42], [0, 120, 74, 42]]
		default:
			return [[10, 10, 50, 150], [20, 20, 150, 50]]
	}
}