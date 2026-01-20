	object_const_def
	const KARENSROOM_KAREN

KarensRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_TILES, .KarensRoomDoors

.LockDoor:
	sdefer .KarensDoorLocksBehindYou
	end

.DummyScene:
	end

.KarensRoomDoors:
	checkevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 14, $2a ; wall
.KeepEntranceOpen:
	checkevent EVENT_KARENS_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 2, $16 ; open door
.KeepExitClosed:
	endcallback

.KarensDoorLocksBehindYou:
	applymovement PLAYER, KarensRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 14, $2a ; wall
	reloadmappart
	closetext
	setscene SCENE_FINISHED
	setevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	waitsfx
	end

KarenScript_Battle:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ELITE_4_KAREN
	iftrue KarenScript_AfterBattle
	readvar VAR_BADGES
	if_less_than 16, .OriginalText
	writetext KarenScript_KarenRematchBeforeText
	sjump .EndIntroText
.OriginalText
	writetext KarenScript_KarenBeforeText
.EndIntroText
	waitbutton
	closetext
	winlosstext KarenScript_KarenBeatenText, 0
	readvar VAR_BADGES
	if_greater_than 15, .Rematch
	loadtrainer KAREN, KAREN1
	sjump .LoadtrainerEnd
.Rematch:
	loadtrainer KAREN, 2
.LoadtrainerEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ELITE_4_KAREN
	opentext
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	changeblock 4, 2, $16 ; open door
	reloadmappart
	closetext
	setevent EVENT_KARENS_ROOM_EXIT_OPEN
	waitsfx
	end

KarenScript_AfterBattle:
	writetext KarenScript_KarenDefeatText
	waitbutton
	closetext
	end

KarensRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

KarenScript_KarenRematchBeforeText:
	text "KAREN: Ah," ; "KAREN: Ah,"
	line "Jij weer." ; "it's you again."

    para "Ik hoop dat je" ; "I trust you"
    line "mijn overtuiging" ; "haven't forgotten"
	cont "onthouden hebt:" ; "my belief:"

    para "Ware kracht stemt" ; "True strength"
    line "uit vertrouwen in" ; "arises from trust"
    cont "je #MON." ; "in one's #MON."

    para "Sinds onze laatste" ; "Since our last"
    line "ontmoeting is de" ; "encounter, my"

	para "band met mijn" ;  "bond with my"
	line "#MON verder" ; "#MON has"
    cont "verstevigd." ; "deepened further."

    para "Ben je klaar om" ; "Are you ready"
    line "te strijden tegen" ; ; "to face a team"
    cont "een team met een" ; "united by an"
    cont "onbreekbare band?" ; "unbreakable bond?"

    para "Toon me de kracht" ; "Show me the power"
    line "van de band met" ; "of the bond with"
    cont "je #MON." ; "your #MON."
	done

KarenScript_KarenBeforeText:
	text "Ik ben KAREN van" ; "I am KAREN of the"
	line "de ELITE FOUR." ; "ELITE FOUR."

	para "Jij bent <PLAYER>?" ; "You're <PLAYER>?"
	line "Wat grappig." ; "How amusing."

	para "Ik ben dol op" ; "I love dark-type"
	line "DUISTER-type" ; "#MON."
	cont "#MON."

	para "Ik vind hun wilde," ; "I find their wild,"
	line "ruwe imago zo" ; "tough image to be"

	para "aanlokkelijk. En" ; "so appealing. And"
	line "ze zijn krachtig." ; "they're so strong."

	para "Denk je ze aan te" ; "Think you can take"
	line "kunnen? Probeer" ; "them? Just try to"
	cont "het maar." ; "entertain me."

	para "We beginnen." ; "Let's go."
	done

KarenScript_KarenBeatenText:
	text "Zo, je bent echt" ; "Well, aren't you"
	line "goed. Ik kan dat" ; "good. I like that"
	cont "waarderen." ; "in a trainer."
	done

KarenScript_KarenDefeatText:
	text "Sterke #MON." ; "Strong #MON."

	para "Zwakke #MON." ; "Weak #MON."

	para "Dat is slechts het" ; "That is only the"
	line "egoïstische beeld" ; "selfish perception"
	cont "van mensen." ; "of people."

	para "Echt vaardige" ; "Truly skilled"
	line "trainers horen te" ; "trainers should"

	para "winnen met hun" ; "try to win with"
	line "favorieten." ; "their favorites."

	para "Ik waardeer je" ; "I like your style."
	line "stijl. Jij snapt" ; "You understand"
	cont "wat belangrijk is." ; "what's important."

	para "Ga verder--de" ; "Go on--the CHAM-"
	line "KAMPIOEN wacht." ; "PION is waiting."
	done

KarensRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, BRUNOS_ROOM, 3
	warp_event  5, 17, BRUNOS_ROOM, 4
	warp_event  4,  2, LANCES_ROOM, 1
	warp_event  5,  2, LANCES_ROOM, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_KAREN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, KarenScript_Battle, -1
