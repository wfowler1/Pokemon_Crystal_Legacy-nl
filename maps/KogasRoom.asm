	object_const_def
	const KOGASROOM_KOGA

KogasRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .KogasRoomDoors

.LockDoor:
	sdefer .KogasDoorLocksBehindYou
	end

.DummyScene:
	end

.KogasRoomDoors:
	checkevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_KOGAS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

.KogasDoorLocksBehindYou:
	applymovement PLAYER, KogasRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	reloadmappart
	closetext
	setscene SCENE_FINISHED
	setevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KogaScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_KOGA
	iftrue KogaScript_AfterBattle
	readvar VAR_BADGES
	if_less_than 16, .OriginalText
	writetext KogaScript_KogaRematchBeforeText
	sjump .EndIntroText
.OriginalText
	writetext KogaScript_KogaBeforeText
.EndIntroText
	waitbutton
	closetext
	winlosstext KogaScript_KogaBeatenText, 0
	readvar VAR_BADGES
	if_greater_than 15, .Rematch
	loadtrainer KOGA, KOGA1
	sjump .LoadtrainerEnd
.Rematch:
	loadtrainer KOGA, 2
.LoadtrainerEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_KOGA

	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	readvar VAR_BADGES
	if_less_than 9, .BaseCap
	sjump .DontUpdateBadge
.BaseCap
	loadmem wLevelCap, 54 ; update level cap for hard mode
.DontUpdateBadge

	opentext
	writetext KogaScript_KogaDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	reloadmappart
	closetext
	setevent EVENT_KOGAS_ROOM_EXIT_OPEN
	waitsfx
	end

KogaScript_AfterBattle:
	writetext KogaScript_KogaDefeatText
	waitbutton
	closetext
	end

KogasRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

KogaScript_KogaRematchBeforeText:
	text "KOGA:"
	line "Fwahahahaha!"

    para "You return, brave"
    line "challenger."

	para "My ninja skills"
    line "have sharpened."

    para "New sinister traps"
    line "await you."

    para "Poison, sleep, and"
    line "more... Be ready!"

    para "Fwahahahaha!"

    para "Show me how"
    line "you've grown!"
    done

KogaScript_KogaBeforeText:
	text "Fwahahahaha!"

	para "Ik ben KOGA van de" ; "I am KOGA of the"
	line "ELITE FOUR."

	para "Ik leef in de" ; "I live in shadows,"
	line "schaduw als ninja!" ; "a ninja!"

	para "M'n complexe stijl" ; "My intricate style"
	line "zal je verbazen" ; "will confound and"
	cont "en verwoesten!" ; "destroy you!"

	para "Verwarring, slaap," ; "Confusion, sleep,"
	line "gif…" ; "poison…"

	para "Bereid voor om" ; "Prepare to be the"
	line "mijn slachtoffer" ; "victim of my sin-"
	cont "te worden!" ; "ister technique!"

	para "Fwahahahaha!"

	para "#MON gaat om" ; "#MON is not"
	line "meer dan brute" ; "merely about brute"

	para "kracht--dat zul je" ; "force--you shall"
	line "snel zien!" ; "see soon enough!"
	done

KogaScript_KogaBeatenText:
	text "Ah!" ; "Ah!"
	line "Je hebt je" ; "You have proven"
	cont "bewezen!" ; "your worth!"
	done

KogaScript_KogaDefeatText:
	text "Ik heb alles" ; "I subjected you to"
	line "gegeven dat ik in" ; "everything I could"
	cont "mij had." ; "muster."

	para "Maar het was niet" ; "But my efforts"
	line "genoeg. Ik moet" ; "failed. I must"
	cont "mezelf verbeteren." ; "hone my skills."

	para "Ga voort en stel" ; "Go on to the next"
	line "jezelf op de" ; "room, and put your"
	cont "proef!" ; "abilities to test!"
	done

KogasRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, WILLS_ROOM, 2
	warp_event  5, 17, WILLS_ROOM, 3
	warp_event  4,  2, BRUNOS_ROOM, 1
	warp_event  5,  2, BRUNOS_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_KOGA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, KogaScript_Battle, -1
