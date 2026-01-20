	object_const_def
	const WILLSROOM_WILL

WillsRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .WillsRoomDoors

.LockDoor:
	sdefer .WillsDoorLocksBehindYou
	end

.DummyScene:
	end

.WillsRoomDoors:
	checkevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_WILLS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

.WillsDoorLocksBehindYou:
	applymovement PLAYER, WillsRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	reloadmappart
	closetext
	setscene SCENE_FINISHED
	setevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

WillScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_WILL
	iftrue WillScript_AfterBattle
	readvar VAR_BADGES
	if_less_than 16, .OriginalText
	writetext WillScript_WillRematchBeforeText
	sjump .EndIntroText
.OriginalText
	writetext WillScript_WillBeforeText
.EndIntroText
	waitbutton
	closetext
	winlosstext WillScript_WillBeatenText, 0
	readvar VAR_BADGES
	if_greater_than 15, .Rematch
	loadtrainer WILL, WILL1
	sjump .LoadtrainerEnd
.Rematch:
	loadtrainer WILL, 2
.LoadtrainerEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_WILL
		
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	readvar VAR_BADGES
	if_less_than 9, .BaseCap
	sjump .DontUpdateBadge
.BaseCap
	loadmem wLevelCap, 52 ; update level cap for hard mode
.DontUpdateBadge

	opentext
	writetext WillScript_WillDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	reloadmappart
	closetext
	setevent EVENT_WILLS_ROOM_EXIT_OPEN
	waitsfx
	end

WillScript_AfterBattle:
	writetext WillScript_WillDefeatText
	waitbutton
	closetext
	end

WillsRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

WillScript_WillRematchBeforeText:
	text "WILL: Ah, welkom" ; "WILL:"
	line "terug." ; "Ah, welcome back."

    para "Ik voorzag deze" ; "I have foreseen"
    line "ontmoeting." ; "this encounter."

    para "Mijn psychische" ; "My psychic #MON"
    line "#MON en ik evo-" ; "and I have"
	cont "luveerden, door" ; "evolved,"

    para "nieuwe tactieken" ; "developing new"
	line "te ontwikkelen." ; "tactics."

    para "Bereid je voor op" ; "Prepare yourself"
    line "een gevecht met" ; "for a battle of"
    cont "betere strategie" ; "enhanced strategy"
	cont "en macht." ; "and might."

    para "Eens kijken of je" ; "Let us see if"
    line "vooruitziende blik" ; "your foresight"
    cont "de mijne evenaart." ; "matches mine."
	done

WillScript_WillBeforeText:
	text "Welkom bij de" ; "Welcome to #MON"
	line "#MON-LEAGUE," ; "LEAGUE, <PLAYER>."
	cont "<PLAYER>."

	para "Laat mij mezelf" ; "Allow me to intro-"
	line "introduceren." ; "duce myself. I am"
	cont "Ik ben WILL." ; "WILL."

	para "Overal ter wereld" ; "I have trained all"
	line "heb ik mijn psy-" ; "around the world,"

	para "chische #MON" ; "making my psychic"
	line "getraind." ; "#MON powerful."

	para "En nu hoor ik" ; "And, at last, I've"
	line "eindelijk bij de" ; "been accepted into"
	cont "ELITE FOUR." ; "the ELITE FOUR."

	para "Ik kan alleen maar" ; "I can only keep"
	line "beter worden!" ; "getting better!"

	para "Verliezen is" ; "Losing is not an"
	line "geen optie!" ; "option!"
	done

WillScript_WillBeatenText:
	text "N… Niet te…" ; "I… I can't…"
	line "geloven…" ; "believe it…"
	done

WillScript_WillDefeatText:
	text "Ik verander mijn" ; "Even though I was"
	line "koers niet, ook al" ; "defeated, I won't"
	cont "ben ik verslagen." ; "change my course."

	para "Ik blijf vechten" ; "I will continue"
	line "totdat ik boven" ; "battling until I"

	para "alle andere" ; "stand above all"
	line "trainers sta!" ; "trainers!"

	para "Goed, <PLAYER>, ga" ; "Now, <PLAYER>, move"
	line "verder en ontdek" ; "on and experience"

	para "de ware felheid" ; the true ferocity"
	line "van de ELITE FOUR." ; "of the ELITE FOUR."
	done

WillsRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 17, INDIGO_PLATEAU_POKECENTER_1F, 4
	warp_event  4,  2, KOGAS_ROOM, 1
	warp_event  5,  2, KOGAS_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_WILL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WillScript_Battle, -1
