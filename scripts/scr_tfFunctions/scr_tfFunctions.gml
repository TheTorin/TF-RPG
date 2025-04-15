#macro CURR_SPR global.party[partyMember].sprites
#macro CURR_CHR global.party[partyMember]
#macro CURR_TF global.party[partyMember].tfs
#macro SPR_W 64
#macro SPR_H 64
#macro SPR_XORIG 0
#macro SPR_YORIG 0

enum LIMBS {
	HEAD,
	CHEST,
	LARM,
	RARM,
	LLEG,
	RLEG
}

enum TRANSFORMS {
	SPECIES,
	WEIGHT,
	MUSCLE,
	GENDER,
	YEARS
}

enum SPECIES_TF {
	HUMAN,
	REPTILE,
	AVIAN,
	AQUATIC,
	BEAST,
	CRITTER,
	ARMOR,
	ELEMENTAL,
	PUNISHMENT
}

function getSprite(TF, bodyPart, anim) {
	var asset;
	switch (bodyPart) {
		case LIMBS.HEAD:
			asset = asset_get_index("spr_t" + string_trim(TF) + "Head" + string_trim(anim));
		break;
		case LIMBS.CHEST:
			asset = asset_get_index("spr_t" + string_trim(TF) + "Chest" + string_trim(anim));
		break;
		case LIMBS.LARM:
			asset = asset_get_index("spr_t" + string_trim(TF) + "LArm" + string_trim(anim));
		break;
		case LIMBS.LLEG:
			asset = asset_get_index("spr_t" + string_trim(TF) + "LLeg" + string_trim(anim));
		break;
		case LIMBS.RARM:
			asset = asset_get_index("spr_t" + string_trim(TF) + "RArm" + string_trim(anim));
		break;
		case LIMBS.RLEG:
			asset = asset_get_index("spr_t" + string_trim(TF) + "RLeg" + string_trim(anim));
		break;
		default:
			asset = asset_get_index("spr_t" + string_trim(TF) + string_trim(bodyPart) + string_trim(anim));
	}
	if (asset == -1 or asset_get_type(asset) != asset_sprite) {
		show_error(string("During TF sprite lookup, sprite asset did not exist! TF: {0}, Limb: {1}, Anim: {2}", TF, bodyPart, anim), true);
		return;
	}
	else return asset;	
}

function inflictTF(TF, bodyPart, partyMember) {
	switch (bodyPart) {
		case LIMBS.CHEST:
			CURR_TF.chest = TF;
		break;
		case LIMBS.HEAD:
			CURR_TF.head = TF;
		break;
		case LIMBS.LARM:
			CURR_TF.LArm = TF;
		break;
		case LIMBS.RARM:
			CURR_TF.RArm = TF;
		break;
		case LIMBS.LLEG:
			CURR_TF.LLeg = TF;
		break;
		case LIMBS.RLEG:
			CURR_TF.RLeg = TF;
		break;
		default:
			show_error("Attempted to inflict TF without a valid limb given!", true);
	}
	array_push(global.queuedTFs, partyMember);
}

function updateSprites(partyMember) {
	//IMPORTANT!!!
	//ONLY CALL THIS FUNCTION DURING THE >>DRAW STEP<<
	//OTHERWISE IT !WILL! !NOT! !WORK!
	var surf, spr;
	surf = surface_create(64, 64);
	surface_set_target(surf);
		
	var anims = variable_struct_get_names(CURR_SPR);
	array_pop(anims);
	//Each animation/sprite
	for (var i = 0; i < array_length(anims); i++) {
		//Each frame
		for (var o = 0; o < sprite_get_number(getSprite(CURR_TF.head, LIMBS.CHEST, anims[i])); o++) {
			draw_clear_alpha(c_white, 0);
			draw_sprite(getSprite(CURR_TF.head, LIMBS.HEAD, anims[i]), o, 0, 0);
			draw_sprite(getSprite(CURR_TF.chest, LIMBS.CHEST, anims[i]), o, 0, 0);
			draw_sprite(getSprite(CURR_TF.LArm, LIMBS.LARM, anims[i]), o, 0, 0);
			draw_sprite(getSprite(CURR_TF.RArm, LIMBS.RARM, anims[i]), o, 0, 0);
			draw_sprite(getSprite(CURR_TF.LLeg, LIMBS.LLEG, anims[i]), o, 0, 0);
			draw_sprite(getSprite(CURR_TF.RLeg, LIMBS.RLEG, anims[i]), o, 0, 0);
			
			//Annoying, but it's late and I'm lazy. 5am decisions babyyy
			if (o == 0) {
				spr = sprite_create_from_surface(surf, 0, 0, SPR_W, SPR_H, true, false, SPR_XORIG, SPR_YORIG);
			}
			else {
				sprite_add_from_surface(spr, surf, 0, 0, SPR_W, SPR_H, true, false);
			}
		}
		
		sprite_save_strip(spr, "spr_Char" + string(partyMember) + anims[i]);
		
		if (CURR_SPR[$ anims[i]] != pointer_null) {
			sprite_assign(CURR_SPR[$ anims[i]], spr);	
		}
		else {
			CURR_SPR[$ anims[i]] = sprite_duplicate(spr);
		}
		
		sprite_set_speed(CURR_SPR[$ anims[i]], 4, spritespeed_framespersecond);
		
		sprite_flush(spr);
	}
		
	surface_reset_target();
	surface_free(surf);
	sprite_delete(spr);
}