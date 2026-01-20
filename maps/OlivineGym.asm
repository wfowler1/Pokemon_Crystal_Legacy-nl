	object_const_def
	const OLIVINEGYM_JASMINE
	const OLIVINEGYM_GYM_GUIDE

OlivineGym_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .FightDone
	writetext Jasmine_SteelTypeIntro
	waitbutton
	closetext
	winlosstext Jasmine_BetterTrainer, 0
	;  Level scaling if statments
	readvar VAR_BADGES
	ifequal 6, .SevenBadges
	ifequal 5, .SixBadges
	ifequal 4, .FiveBadges
.FiveBadges:
	loadtrainer JASMINE, JASMINE1
	sjump .OlivineGymJasmineScriptEnd
.SixBadges:
	loadtrainer JASMINE, 2
	sjump .OlivineGymJasmineScriptEnd
.SevenBadges:
	loadtrainer JASMINE, 3
	sjump .OlivineGymJasmineScriptEnd
.OlivineGymJasmineScriptEnd
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_3
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_3
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	opentext
	writetext Text_ReceivedMineralBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE

	; Update level caps with level scaling
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	readvar VAR_BADGES
	ifequal 7, .SevenBadgeCap
	ifequal 6, .SixBadgeCap
	ifequal 5, .FiveBadgeCap
.FiveBadgeCap:
	loadmem wLevelCap, 36 ; update level cap for hard mode
	sjump .LevelCapScriptEnd
.SixBadgeCap:
	loadmem wLevelCap, 38 ; update level cap for hard mode
	sjump .LevelCapScriptEnd
.SevenBadgeCap:
	loadmem wLevelCap, 45 ; update level cap for hard mode
	sjump .LevelCapScriptEnd
.DontUpdateBadge
.LevelCapScriptEnd:

	readvar VAR_BADGES
	scall OlivineGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue .GotIronTail
	writetext Jasmine_BadgeSpeech
	promptbutton
	verbosegiveitem TM_IRON_TAIL
	iffalse .NoRoomForIronTail
	setevent EVENT_GOT_TM23_IRON_TAIL
	writetext Jasmine_IronTailSpeech
	waitbutton
	closetext
	end

.GotIronTail:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotBeatE4
	writetext JasmineRematchText
	yesorno
	iftrue .JasmineRematch
	sjump .NoRoomForIronTail
.NotBeatE4
	writetext Jasmine_GoodLuck
	waitbutton
.NoRoomForIronTail:
	closetext
	end

.JasmineRematch:
	special HealParty
	winlosstext Jasmine_RematchDefeatText, 0
	loadtrainer JASMINE, 4
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_4
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_4
	startbattle
	reloadmapafterbattle
	end

OlivineGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

OlivineGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_JASMINE
	iftrue .OlivineGymGuideWinScript
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse .OlivineGymGuidePreScript
	opentext
	writetext OlivineGymGuideText
	waitbutton
	closetext
	end

.OlivineGymGuideWinScript:
	opentext
	writetext OlivineGymGuideWinText
	waitbutton
	closetext
	end

.OlivineGymGuidePreScript:
	opentext
	writetext OlivineGymGuidePreText
	waitbutton
	closetext
	end

OlivineGymStatue:
	checkflag ENGINE_MINERALBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, JASMINE, JASMINE1
	jumpstd GymStatue2Script

Jasmine_SteelTypeIntro:
	text "…Bedankt voor je" ; "…Thank you for"
	line "hulp in de" ; "your help at the"
	cont "VUURTOREN…" ; "LIGHTHOUSE…"

	para "Maar dit is" ; "But this is dif-"
	line "anders. Sta me toe" ; "ferent. Please"

	para "om mezelf te" ; "allow me to intro-"
	line "introduceren." ; "duce myself."

	para "Ik ben JASMINE," ; "I am JASMINE, a"
	line "een GYMLEIDER. Ik" ; "GYM LEADER. I use"
	cont "gebruik het" ; "the STEEL-type."
	cont "STAAL-type." ;

	para "…Ken je het" ; "…Do you know about"
	line "STAAL-type?" ; "the STAAL-type?"

	para "Het is een type" ; "It's a type that"
	line "dat nog maar pas" ; "was only recently"
	cont "is ontdekt." ; "discovered."

	para "…Um… Kan ik" ; "…Um… May I begin?"
	line "beginnen?" ;
	done

Jasmine_BetterTrainer:
	text "…Je bent een" ; "…You are a better"
	line "betere trainer" ; "trainer than me,"

	para "dan ik, in zowel" ; "in both skill and"
	line "vaardigheid als" ; "kindness."
	cont "vriendelijkheid." ;

	para "In overeenstemming" ; "In accordance with"
	line "met de LEAGUE-" ; "LEAGUE rules, I"

	para "regels, overhandig" ; "confer upon you"
	line "ik je deze BADGE." ; "this BADGE."
	done

Text_ReceivedMineralBadge:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "MINERAALBADGE." ; "MINERALBADGE."
	done

Jasmine_BadgeSpeech:
	text "MINERAALBADGE" ; "MINERALBADGE"
	line "verhoogt #MON-" ; "raises #MON's"
	cont "AFWEER." ; "DEFENSE."

	para "…Um… Neem" ; "…Um… Please take"
	line "dit ook…" ; "this too…"
	done

Text_ReceivedTM09: ; unreferenced
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "TM09."
	done

Jasmine_IronTailSpeech:
	text "…Met die TM" ; "…You could use"
	line "kun je IJZER-" ; "that TM to teach"
	cont "STAART leren." ; "IRON TAIL."
	done

Jasmine_GoodLuck:
	text "Um… Ik weet niet" ; "Um… I don't know"
	line "hoe ik dit moet" ; "how to say this,"
	cont "zeggen, maar" ; "but good luck…"
	cont "veel geluk…" ;
	done

JasmineRematchText:
	text "…Gefeliciteerd," ; "Congratulations,"
    line "JOHTO KAMPIOEN." ; "JOHTO CHAMPION."

    para "Je bent zo sterk" ; "You have become"
    line "geworden…" ; "so strong…"

    para "Ik vraag me af of" ; "I wonder if I"
    line "ik verbeterd ben." ; "have improved."

    para "Zou je dat graag" ; "Would you like"
    line "willen testen?" ; "to test that?"

    para "Wil je een rematch" ; "Want to have a"
    line "met me?" ; "rematch with me?"
	done

Jasmine_RematchDefeatText:
	text "…Je bent een" ; "…You are a better"
	line "betere trainer dan" ; "trainer than me,"

	para "mij in zowel" ; "in both skill and"
	line "vaardigheid als" ; "kindness."
	cont "vriendelijkheid." ; 
	done

OlivineGymGuideText:
	text "JASMINE gebruikt" ; "JASMINE uses the"
	line "het nieuw ontdekte" ; "newly discovered"
	cont "STAAL-type." ; "STEEL-type."

	para "Ze is gekend omdat" ; "She's known for"
	line "er twee toppers in" ; "having not one,"
	cont "in haar team zijn." ; "but two aces."
	
	para "De eerste is een" ; "The first is a"
	line "metalen insect met" ; "metal bug that can"
	
	para "een truc om AANVAL" ; "use a technique to"
	line "te vergroten." ; "boost its ATTACK."
	
	para "Vuur kan het dan" ; "While fire will"
	line "wel schaden, toch" ; "hurt it, it can"

	para "weet het soms" ; "sometimes endure"
	line "krachtige klappen" ; "powerful blows."
	cont "te weerstaan." ; 
	
	para "De tweede is een" ; "The second is a"
	line "reuzeslang van" ; "giant iron snake"
	
	para "ijzer met vele ma-" ; "with lots of"
	line "chtige aanvallen." ; "powerful moves."
	
	para "Benader die" ; "Approach it with"
	line "voorzichtig." ; "caution."
	
	para "Deze lijkt traag," ; "It may look slow,"
	line "toch heb ik gezien" ; but I've seen it"

	para "hoe ie eerst toe-" ; "strike first with"
	line "slaat met verras-" ; shocking displays"
	cont "sende SNELHEID." ; "of SPEED."
	done

OlivineGymGuideWinText:
	text "Dat was geweldig." ; "That was awesome."

	para "Het STAAL-type," ; "The STEEL-type,"
	line "hè?" ; "huh?"

	para "Dat was een" ; "That was a close"
	line "zeldzaam" ; "encounter of an"
	cont "goed gevecht!" ; "unknown kind!"
	done

OlivineGymGuidePreText:
	text "JASMINE, de GYM-" ; "JASMINE, the GYM"
	line "LEIDER, is in" ; "LEADER, is at the"
	cont "de VUURTOREN." ; "LIGHTHOUSE."

	para "Ze zorgt voor" ; "She's been tending"
	line "een zieke #MON." ; "to a sick #MON."

	para "Een sterke" ; "A strong trainer"
	line "trainer moet" ; "has to be compas-"
	cont "medeleven tonen." ; "sionate."
	done

OlivineGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuideScript, -1
