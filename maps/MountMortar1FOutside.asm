	object_const_def
	const MOUNTMORTAR1FOUTSIDE_POKE_BALL1
	const MOUNTMORTAR1FOUTSIDE_POKE_BALL2

MountMortar1FOutside_MapScripts:
	def_scene_scripts

	def_callbacks

MountMortarB1FKiyoScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TYROGUE_FROM_KIYO
	iftrue .GotTyrogue
	checkevent EVENT_BEAT_BLACKBELT_KIYO
	iftrue .BeatKiyo
	writetext MountMortarB1FKiyoIntroText
	waitbutton
	closetext
	winlosstext MountMortarB1FKiyoWinText, 0
	loadtrainer BLACKBELT_T, KIYO
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_KIYO
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_KIYO
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLACKBELT_KIYO
	opentext
.BeatKiyo:
	writetext MountMortarB1FTyrogueRewardText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	writetext MountMortarB1FReceiveMonText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke TYROGUE, 10
	setevent EVENT_GOT_TYROGUE_FROM_KIYO
.GotTyrogue:
	writetext MountMortarB1FKiyoGotTyrogueText
	waitbutton
	closetext
	end

.NoRoom:
	writetext MountMortarB1FKiyoFullPartyText
	waitbutton
	closetext
	end

MountMortar1FOutsideTMDefenseCurl:
	itemball TM_DEFENSE_CURL

MountMortar1FOutsideRevive:
	itemball REVIVE

MountMortar1FOutsideHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_MOUNT_MORTAR_1F_OUTSIDE_HIDDEN_HYPER_POTION

MountMortarB1FKiyoIntroText:
	text "Hey!" ; "Hey!"

	para "Ik ben de KARATE" ; "I am the KARATE"
	line "KONING!" ; "KING!"

	para "Ik train hier" ; "I train alone here"
	line "in het donker!" ; "in the dark!"

	para "Jij!" ; "You!"
	line "Vecht met me!" ; "Battle with me!"

	para "Hwaaarggh!" ; "Hwaaarggh!"
	done

MountMortarB1FKiyoWinText:
	text "Waaaarggh!" ; "Hwaaarggh!"
	line "Ik ben verslagen!" ; "I'm beaten!"
	done

MountMortarB1FTyrogueRewardText:
	text "Ik… Ik ben er kapot van." ; "I… I'm crushed…"

	para "Mijn training is" ; "My training is"
	line "nog onvolledig…" ; still not enough…"

	para "Maar verloren is" ; "But a loss is a"
	line "verloren. Dat geef" ; "loss. I admit it."
	cont "ik grif toe." ; 

	para "Als bewijs dat je" ; "As proof that you"
	line "me versloeg, krijg" ; "defeated me, I'll"

	para "je een zeldzame" ; "give you a rare"
	line "vecht #MON." ; "fighting #MON."
	done

MountMortarB1FReceiveMonText:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "TYROGUE." ; "TYROGUE."
	done

MountMortarB1FKiyoGotTyrogueText:
	text "TYROGUE is een" ; "TYROGUE is a"
	line "VECHT-type, die" ; "FIGHTING-type."

	para "in een sterkere" ; "It evolves into a"
	line "#MON evolueert." ; "tougher #MON."

	para "Ga door met het" ; "Keep up the hard"
	line "harde werk. Ik" ; "work. I'll keep"
	cont "train ook verder." ; "training too."

	para "Vaarwel!" ; "Farewell!"
	done

MountMortarB1FKiyoFullPartyText:
	text "Je hebt geen plek" ; "You have no room"
	line "vrij in je team!" ; "in your party!"
	done

MountMortar1FOutside_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 33, ROUTE_42, 3
	warp_event 17, 33, ROUTE_42, 4
	warp_event 37, 33, ROUTE_42, 5
	warp_event 17,  5, MOUNT_MORTAR_2F_INSIDE, 1
	warp_event 11, 21, MOUNT_MORTAR_1F_INSIDE, 1
	warp_event 29, 21, MOUNT_MORTAR_1F_INSIDE, 2
	warp_event 17, 29, MOUNT_MORTAR_B1F, 2
	warp_event  7, 13, MOUNT_MORTAR_1F_INSIDE, 3
	warp_event 33, 13, MOUNT_MORTAR_1F_INSIDE, 4

	def_coord_events

	def_bg_events
	bg_event 25, 22, BGEVENT_ITEM, MountMortar1FOutsideHiddenHyperPotion

	def_object_events
	object_event 11,  15, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MountMortarB1FKiyoScript, -1
	object_event 13, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, MountMortar1FOutsideTMDefenseCurl, EVENT_MOUNT_MORTAR_2F_INSIDE_TM_DEFENSE_CURL
	object_event 31, 18, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, MountMortar1FOutsideRevive, EVENT_MOUNT_MORTAR_1F_OUTSIDE_REVIVE
