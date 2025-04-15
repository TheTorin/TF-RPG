//Return fixed placement. If party is missing characters, then it will highlight their absence
function getPlayerPlacement(_bg) {
	switch(_bg) {
		case spr_TestBG:
			return [[90, 20],[80, 50],[20, 20],[10, 50]];
		default:
			return [[100, 100],[110, 110],[120, 120],[130, 130]];
	}
}