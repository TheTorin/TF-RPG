if (array_length(global.queuedTFs) > 0) {
	global.queuedTFs = array_unique(global.queuedTFs);
	for (var i = 0; i < array_length(global.queuedTFs); i++) {
		updateSprites(global.queuedTFs[i]);	
	}
	global.queuedTFs = [];
}