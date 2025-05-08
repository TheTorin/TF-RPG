event_inherited();
if (hp <= 0)
{
	image_speed = 0;
}
else
{
	if (sprite_index != sprites.Idle) sprite_index = sprites.Idle;
	if (image_speed == 0) image_speed = 1;
}