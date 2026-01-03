	object_const_def
	const OLIVINECITY_SAILOR1
	const OLIVINECITY_STANDING_YOUNGSTER
	const OLIVINECITY_SAILOR2
	const OLIVINECITY_OLIVINE_RIVAL

OlivineCity_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_OLIVINE
	endcallback

OlivineCityRivalSceneTop:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalApproachesTopMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	applymovement PLAYER, OlivineCityPlayerStepsAsideTopMovement
	turnobject PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalLeavesTopMovement
	setscene SCENE_FINISHED
	disappear OLIVINECITY_OLIVINE_RIVAL
	special RestartMapMusic
	special LoadUsedSpritesGFX
	end

OlivineCityRivalSceneBottom:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playsound SFX_ENTER_DOOR
	appear OLIVINECITY_OLIVINE_RIVAL
	waitsfx
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalApproachesBottomMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext OlivineCityRivalText
	waitbutton
	closetext
	applymovement PLAYER, OlivineCityPlayerStepsAsideBottomMovement
	turnobject PLAYER, RIGHT
	applymovement OLIVINECITY_OLIVINE_RIVAL, OlivineCityRivalLeavesBottomMovement
	disappear OLIVINECITY_OLIVINE_RIVAL
	setscene SCENE_FINISHED
	special RestartMapMusic
	special LoadUsedSpritesGFX
	end

OlivineCitySailor1Script:
	jumptextfaceplayer OlivineCitySailor1Text

OlivineCityStandingYoungsterScript:
	faceplayer
	opentext
	random 2
	ifequal 0, .FiftyFifty
	writetext OlivineCityStandingYoungsterPokegearText
	waitbutton
	closetext
	end

.FiftyFifty:
	writetext OlivineCityStandingYoungsterPokedexText
	waitbutton
	closetext
	end

OlivineCitySailor2Script:
	jumptextfaceplayer OlivineCitySailor2Text

OlivineCitySign:
	jumptext OlivineCitySignText

OlivineCityPortSign:
	jumptext OlivineCityPortSignText

OlivineGymSign:
	jumptext OlivineGymSignText

OlivineLighthouseSign:
	jumptext OlivineLighthouseSignText

OlivineCityBattleTowerSign:
	jumptext OlivineCityBattleTowerSignText

OlivineCityPokecenterSign:
	jumpstd PokecenterSignScript

OlivineCityMartSign:
	jumpstd MartSignScript

OlivineCityRivalApproachesTopMovement:
	step DOWN
	step RIGHT
	step RIGHT
	step_end

OlivineCityRivalApproachesBottomMovement:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step_end

OlivineCityRivalLeavesTopMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

OlivineCityRivalLeavesBottomMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

OlivineCityPlayerStepsAsideTopMovement:
	step DOWN
	turn_head UP
	step_end

OlivineCityPlayerStepsAsideBottomMovement:
	step UP
	turn_head DOWN
	step_end

OlivineCityRivalText:
	text "…"

	para "You again?"

	para "There's no need to"
	line "panic. I don't"

	para "bother with wimps"
	line "like you."

	para "Speaking of weak-"
	line "lings, the city's"

	para "GYM LEADER is"
	line "said by some to be"
	
	para "stronger than"
	line "PRYCE, yet is"

	para "supposedly taking"
	line "care of a sick"

	para "#MON at the"
	line "LIGHTHOUSE."

	para "Humph! Boo-hoo!"
	line "Just let sick"
	cont "#MON go!"

	para "A #MON that"
	line "can't battle is"
	cont "worthless!"
	
	para "Why don't you go"
	line "train at the"
	cont "LIGHTHOUSE?"
	
	para "Who knows. It may"
	line "make you a bit"
	cont "less weak!"
	
	para "Maybe then you"
	line "could at least"
	
	para "take on CHUCK"
	line "or PRYCE!"
	done

OlivineCitySailor1Text:
	text "Donkere paden" ; "Dark roads are"
	line "zijn gevaarlijk" ; "dangerous at"
	cont "'s nachts." ; "night."

	para "Maar in het pikke-" ; "But in the pitch-"
	line "donker van de" ; "black of night,"

	para "nacht, is de zee" ; "the sea is even"
	line "verraderlijker!" ; "more treacherous!"

	para "Zonder het baken" ; "Without the beacon"
	line "van de VUURTOREN" ; "of the LIGHTHOUSE"

	para "kan geen schip" ; "to guide it, no"
	line "veilig varen." ; "ship can sail."
	done

OlivineCityStandingYoungsterPokegearText:
	text "Dat dingetje van" ; "That thing you"
	line "jou--het is een" ; "have--it's a #-"
	cont "#GEAR, toch?" ; "GEAR, right? Wow,"
	cont "Wow, dat is cool." ; "that's cool."
	done

OlivineCityStandingYoungsterPokedexText:
	text "Wow, je hebt" ; "Wow, you have a"
	line "een #DEX!" ; "#DEX!"

	para "Dat is echt" ; "That is just so"
	line "heel gaaf." ; "awesome."
	done

OlivineCitySailor2Text:
	text "The league has"
	line "JASMINE pegged"

	para "as the sixth"
	line "strongest GYM"
	cont "LEADER!"
	
	para "Hah! That's"
	line "a load of crud."
	
	para "There's no way"
	line "PRYCE could hurt"
	
	para "JASMINE's Steel"
	line "type #MON!"
	
	para "Bureaucracy if"
	line "you ask me."
	
	para "She's something"
	line "to be feared,"
	cont "That's for sure!"
	done

OlivineCitySignText:
	text "OLIVINE CITY"

	para "De Haven Nabij" ; "The Port Closest"
	line "Verre Oorden" ; "to Foreign Lands"
	done

OlivineCityPortSignText:
	text "OLIVINE HAVEN" ; "OLIVINE PORT"
	line "SNELSCHIP-PIER" ; "FAST SHIP PIER"
	done

OlivineGymSignText:
	text "OLIVINE CITY"
	line "#MON GYMLEIDER:"
	cont "JASMINE" ; "LEADER: JASMINE"

	para "De Meid met een" ; "The Steel-Clad"
	line "Stalen Pantser" ; "Defense Girl"
	done

OlivineLighthouseSignText:
	text "OLIVINE VUURTOREN" ; "OLIVINE LIGHTHOUSE"
	line "Ook bekend als de" ; "Also known as the"
	cont "GLITTER-VUURTOREN" ; "GLITTER LIGHTHOUSE"
	done

OlivineCityBattleTowerSignText:
	text "GEVECHTSTOREN" ; "BATTLE TOWER AHEAD"
	line "RECHTDOOR-Nu open!" ; "Opening Now!"
	done

OlivineCityBattleTowerSignText_NotYetOpen: ; unreferenced
; originally shown when the Battle Tower was closed
	text "BATTLE TOWER AHEAD"
	done

OlivineCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 21, OLIVINE_POKECENTER_1F, 1
	warp_event 10, 11, OLIVINE_GYM, 1
	warp_event 25, 11, OLIVINE_TIMS_HOUSE, 1
	warp_event  0,  0, OLIVINE_HOUSE_BETA, 1 ; inaccessible
	warp_event 29, 11, OLIVINE_PUNISHMENT_SPEECH_HOUSE, 1
	warp_event 13, 15, OLIVINE_GOOD_ROD_HOUSE, 1
	warp_event  7, 21, OLIVINE_CAFE, 1
	warp_event 19, 17, OLIVINE_MART, 2
	warp_event 29, 27, OLIVINE_LIGHTHOUSE_1F, 1
	warp_event 19, 27, OLIVINE_PORT_PASSAGE, 1
	warp_event 20, 27, OLIVINE_PORT_PASSAGE, 2

	def_coord_events
	coord_event 13, 12, SCENE_DEFAULT, OlivineCityRivalSceneTop
	coord_event 13, 13, SCENE_DEFAULT, OlivineCityRivalSceneBottom

	def_bg_events
	bg_event 17, 11, BGEVENT_READ, OlivineCitySign
	bg_event 20, 24, BGEVENT_READ, OlivineCityPortSign
	bg_event  7, 11, BGEVENT_READ, OlivineGymSign
	bg_event 30, 28, BGEVENT_READ, OlivineLighthouseSign
	bg_event  3, 23, BGEVENT_READ, OlivineCityBattleTowerSign
	bg_event 14, 21, BGEVENT_READ, OlivineCityPokecenterSign
	bg_event 20, 17, BGEVENT_READ, OlivineCityMartSign

	def_object_events
	object_event 26, 27, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor1Script, -1
	object_event 20, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineCityStandingYoungsterScript, -1
	object_event 17, 21, SPRITE_SAILOR, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCitySailor2Script, -1
	object_event 10, 11, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_OLIVINE_CITY
