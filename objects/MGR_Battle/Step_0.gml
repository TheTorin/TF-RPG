if (array_length(queuedUnits) > 0) {
	unitTakingTurn = true;
	turn++;
	currUnitTurn = array_shift(queuedUnits);
}