kbrdRight = keyboard_check(vk_right) or keyboard_check(ord("D"));
kbrdLeft = keyboard_check(vk_left) or keyboard_check(ord("A"));
kbrdUp = keyboard_check(vk_up) or keyboard_check(ord("W"));
kbrdDown = keyboard_check(vk_down) or keyboard_check(ord("S"));

xSpd = (kbrdRight - kbrdLeft) * moveSpd;
ySpd = (kbrdDown - kbrdUp) * moveSpd;

if place_meeting(x + xSpd, y, obj_Wall) == true {
	xSpd = 0;
}

if place_meeting(x, y + ySpd, obj_Wall) == true {
	ySpd = 0;
}

x += xSpd;
y += ySpd;