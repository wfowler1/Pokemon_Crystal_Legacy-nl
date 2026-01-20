	object_const_def
	const VICTORYROAD_SILVER
	const VICTORYROAD_POKE_BALL1
	const VICTORYROAD_POKE_BALL2
	const VICTORYROAD_POKE_BALL3
	const VICTORYROAD_POKE_BALL4
	const VICTORYROAD_POKE_BALL5
	const VICTORYROAD_MOLTRES

VictoryRoad_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

VictoryRoadRivalLeft:
	moveobject VICTORYROAD_SILVER, 18, 11
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleApproachMovement1
	scall VictoryRoadRivalNext
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleExitMovement1
	disappear VICTORYROAD_SILVER
	setscene SCENE_FINISHED
	playmapmusic
	end

VictoryRoadRivalRight:
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear VICTORYROAD_SILVER
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleApproachMovement2
	scall VictoryRoadRivalNext
	applymovement VICTORYROAD_SILVER, VictoryRoadRivalBattleExitMovement2
	disappear VICTORYROAD_SILVER
	setscene SCENE_FINISHED
	playmapmusic
	end

VictoryRoadRivalNext:
	turnobject PLAYER, DOWN
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext VictoryRoadRivalBeforeText
	waitbutton
	closetext
	setevent EVENT_RIVAL_VICTORY_ROAD
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .GotTotodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .GotChikorita
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_TOTODILE
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_TOTODILE
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.GotTotodile:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_CHIKORITA
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_CHIKORITA
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.GotChikorita:
	winlosstext VictoryRoadRivalDefeatText, VictoryRoadRivalVictoryText
	setlasttalked VICTORYROAD_SILVER
	loadtrainer RIVAL1, RIVAL1_5_CYNDAQUIL
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_RIVAL1_5_CYNDAQUIL
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_RIVAL1_5_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.AfterBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext VictoryRoadRivalAfterText
	waitbutton
	closetext
	end

VictoryRoadTMEarthquake:
	itemball TM_EARTHQUAKE

VictoryRoadMaxRevive:
	itemball MAX_REVIVE

VictoryRoadFullRestore:
	itemball FULL_RESTORE

VictoryRoadFullHeal:
	itemball FULL_HEAL

VictoryRoadHPUp:
	itemball HP_UP

VictoryRoadHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_VICTORY_ROAD_HIDDEN_MAX_POTION

VictoryRoadHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_VICTORY_ROAD_HIDDEN_FULL_HEAL

VictoryRoadRivalBattleApproachMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

VictoryRoadRivalBattleApproachMovement2:
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

VictoryRoadRivalBattleExitMovement1:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

VictoryRoadRivalBattleExitMovement2:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step_end

MoltresScript:
	opentext
	writetext MoltresBattleText
	cry MOLTRES
	waitbutton
	closetext
	loadwildmon MOLTRES, 60
	startbattle
	disappear VICTORYROAD_MOLTRES
	setevent EVENT_CAUGHT_MOLTRES
	reloadmapafterbattle
	end

MoltresBattleText:
	text "Gyaoo!" ; "Gyaoo!"
	done

VictoryRoadRivalBeforeText:
	text "Ho, stop." ; "Hold it."

	para "…Ga je de" ; "…Are you going to"
	line "#MON-LEAGUE-" ; "take the #MON"
	cont "uitdaging aan?" ; "LEAGUE challenge?"

	para "… Laat me niet" ; "…Don't make me"
	line "lachen." ; "laugh."

	para "Je bent zoveel" ; "You're so much"
	line "zwakker dan ik." ; "weaker than I am."
	
	para "Maar ik heb" ; "Even so, I've"
	line "ingezien dat het" ; "realized there"

	para "om meer draait dan" ; "is more to it"
	line "alleen macht." ; "than power."
	
	para "Ik ben begonnen te" ; "I've begun to"
	line "begrijpen wat die" ; "understand what"

	para "drakenmeester" ; "that dragon master"
	line "tegen me zei…" ; "said to me…"

	para "Liefde, vrienden,…" ; "Love, friendship.."
	line "dat is wat de" ; "it's what the"
	cont "ouderen in" ; "elders in the"
	
	para "DRAGON'S DEN" ; "DRAGON'S DEN"
	line "ook zeiden." ; "said too."
	
	para "Ik moet zorgen" ; "I need to care"
	line "voor mijn team." ; "for my team."
	
	para "Ze waren er altijd" ; "They've been with"
	line "voor me en ik heb" ; "me through it all"
	
	para "ze als pionnen" ; "and I have treated"
	line "behandeld." ; "them like pawns."
	
	para "Maar ik beloof!" ; "But I promise!"
	line "Ik zal voor jullie" ; "I will care for"
	cont "allemaal zorgen." ; "all of you."
	
	para "Samen worden we" ; "Together, we"
	line "niet te stoppen." ; "will become"
;	cont "unstoppable."
	
	para "Wat? PUPITAR" ; "What? PUPITAR"
	line "evolueert!" ; "is evolving!"
	
	para "............" ; "............"
	line "............" ; "............"
	
	para "Gefeliciteerd!" ; "Congratulations!"
	line "Je PUPITAR" ; "Your PUPITAR"

	para "evolueerde in" ; "evolved into"
	line "TYRANITAR?" ; "TYRANITAR?"
	
	para ".....Wat?" ; ".....What?"
	line "TYRANITAR?" ; "TYRANITAR?"
	
	para "Maar......." ; "But......."
	line "level....." ; "level....."
	
	para "Ah nee, ik vat 'm." ; "Ah no, I see."
	line "Ik heb gehoord van" ; "I've heard of"
	
	para "versnelde evolutie" ; "rare instances"
	line "in zeer zeldzame" ;"of early evol-"
	cont "gevallen." ; "ution."
	
	para "Sommigen zeggen" ; "Some say that"
	line "dat door liefde," ; "through love,"
	
	para "de drakenmeester" ; "the dragon"
	line "dit ook kon doen." ; "master was able"
	
;	para "to do such a"
;	line "thing too."
	
	para "Misschien komt het" ; "Perhaps it was"
	line "door het ROCKET" ; "the ROCKETs"
	cont "radiosignaal." ; "radio signal."
	
	para "Doet er niet toe." ; "It matters not."
	line "Kom, we vechten." ; "Let's battle."
	
	para "Mijn vrienden gaan" ; "My friends will"
	line "jou en dan de" ; beat you and then"
	cont "ELITE VIER " ; "the ELITE FOUR."
	cont "verslaan." ; 

	para "<PLAYER>!" ; "<PLAYER>!"
	line "Ik daag je uit!" ; "I challenge you!"
	done

VictoryRoadRivalDefeatText:
	text "…Weer verloren…" ; "…I couldn't win…"

	para "Ik deed mijn" ; "I gave it every-"
	line "uiterste best…" ; "thing I had…"

	para "Wat jij hebt," ; "What you possess,"
	line "en wat ik mis…" ; "and what I lack…"
	done

VictoryRoadRivalAfterText:
	text "…Ik geef niet op" ; "…I haven't given up"
	line "om de allerbeste" ; "on becoming the"
	cont "trainer te worden…" ; "greatest trainer…"

	para "Maar dat is ok," ; "But that's okay,"
	line "op een dag keer ik" ; "I will one day"

	para "weer en word ik" ; "return and"
	line "sterker." ; "become stronger."

	para "Op die dag zal ik" ; "When I do, I will"
	line "je uitdagen." ; "challenge you."

	para "En dan versla ik" ; "And I'll beat you"
	line "je met alle kracht" ; "down with all my"
	cont "die ik heb." ; "power."

	para "Kom op team!" ; "Come on guys!"
	line "We gaan!" ; "let's go!"
	done

VictoryRoadRivalVictoryText:
	text "Wat een kracht!" ; "What power!"

	para "Niets kan vriend-" ; "When it comes down"
	line "schap verslaan," ; "to it, nothing can"
	cont "als het er op" ; "beat friendhship."
	cont "aankomt."

	para "ik heb niets" ; "I don't need any-"
	line "anders nodig." ; "thing else."
	done

VictoryRoad_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 67, VICTORY_ROAD_GATE, 5
	warp_event  1, 49, VICTORY_ROAD, 3
	warp_event  1, 35, VICTORY_ROAD, 2
	warp_event 13, 31, VICTORY_ROAD, 5
	warp_event 13, 17, VICTORY_ROAD, 4
	warp_event 17, 33, VICTORY_ROAD, 7
	warp_event 17, 19, VICTORY_ROAD, 6
	warp_event  0, 11, VICTORY_ROAD, 9
	warp_event  0, 27, VICTORY_ROAD, 8
	warp_event 13,  5, ROUTE_23, 3

	def_coord_events
	coord_event 12,  8, SCENE_DEFAULT, VictoryRoadRivalLeft
	coord_event 13,  8, SCENE_DEFAULT, VictoryRoadRivalRight

	def_bg_events
	bg_event  3, 29, BGEVENT_ITEM, VictoryRoadHiddenMaxPotion
	bg_event  3, 65, BGEVENT_ITEM, VictoryRoadHiddenFullHeal

	def_object_events
	object_event 18, 13, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_VICTORY_ROAD
	object_event  3, 28, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadTMEarthquake, EVENT_VICTORY_ROAD_TM_EARTHQUAKE
	object_event 12, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadMaxRevive, EVENT_VICTORY_ROAD_MAX_REVIVE
	object_event 18, 29, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullRestore, EVENT_VICTORY_ROAD_FULL_RESTORE
	object_event 15, 48, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadFullHeal, EVENT_VICTORY_ROAD_FULL_HEAL
	object_event  7, 38, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VictoryRoadHPUp, EVENT_VICTORY_ROAD_HP_UP
	object_event 18, 32, SPRITE_MOLTRES_OVERWORLD, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MoltresScript, EVENT_CAUGHT_MOLTRES
