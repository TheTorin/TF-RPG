if point_distance(x, y, obj_Player.x, obj_Player.y) < 50 {
	image_yscale = 2;
	if input_check_pressed("action") {
		createTextbox(name, "Interact");
	}
}
else {
	image_yscale = 0.5;
}