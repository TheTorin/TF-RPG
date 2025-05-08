if (active)
{
	hover += input_check_pressed("down") - input_check_pressed("up");
	if (hover > array_length(options) - 1) hover = 0;
	if (hover < 0) hover = array_length(options) - 1;
	
	//Choose action
	if (input_check_pressed("accept") or input_check_pressed("action")) {
		if (options[hover].func != undefined) && (options[hover].avail = true) {
			var _func = options[hover].func;
			if (options[hover].args != undefined) script_execute_ext(_func, options[hover].args);
			else _func();
		}
	}
	
	if (input_check_pressed("cancel") or input_check_pressed("pause")) {
		if (subMenuLevel > 0) MenuGoBack();	
	}
	
	if (frameCount >= 30) {
		frameCount = 0;
		spriteFrame = !spriteFrame;
	}
	frameCount++;
}