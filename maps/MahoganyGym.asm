	object_const_def
	const MAHOGANYGYM_PRYCE
	const MAHOGANYGYM_BEAUTY1
	const MAHOGANYGYM_ROCKER1
	const MAHOGANYGYM_BEAUTY2
	const MAHOGANYGYM_ROCKER2
	const MAHOGANYGYM_ROCKER3
	const MAHOGANYGYM_GYM_GUIDE

MahoganyGym_MapScripts:
	def_scene_scripts

	def_callbacks

MahoganyGymPryceScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .FightDone
	writetext PryceText_Intro
	waitbutton
	closetext
	winlosstext PryceText_Impressed, 0
	;  Level scaling if statments
	readvar VAR_BADGES
	ifequal 6, .SevenBadges
	ifequal 5, .SixBadges
	ifequal 4, .FiveBadges
.FiveBadges:
	loadtrainer PRYCE, PRYCE1
	sjump .MahoganyGymPryceScriptEnd
.SixBadges:
	loadtrainer PRYCE, 2
	sjump .MahoganyGymPryceScriptEnd
.SevenBadges:
	loadtrainer PRYCE, 3
	sjump .MahoganyGymPryceScriptEnd
.MahoganyGymPryceScriptEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_3
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_3
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PRYCE
	opentext
	writetext Text_ReceivedGlacierBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_GLACIERBADGE

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
	scall MahoganyGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM16_ICY_WIND
	iftrue PryceScript_Defeat
	setevent EVENT_BEAT_SKIER_ROXANNE
	setevent EVENT_BEAT_SKIER_CLARISSA
	setevent EVENT_BEAT_BOARDER_RONALD
	setevent EVENT_BEAT_BOARDER_BRAD
	setevent EVENT_BEAT_BOARDER_DOUGLAS
	writetext PryceText_GlacierBadgeSpeech
	promptbutton
	verbosegiveitem TM_ICY_WIND
	iffalse MahoganyGym_NoRoomForIcyWind
	setevent EVENT_GOT_TM16_ICY_WIND
	writetext PryceText_IcyWindSpeech
	waitbutton
	closetext
	end

PryceScript_Defeat:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotBeatE4
	writetext PryceRematchText
	yesorno
	iftrue .PryceRematch
	sjump .CantRematchYet
.NotBeatE4
	writetext PryceText_CherishYourPokemon
	waitbutton
.CantRematchYet:
	closetext
	end

.PryceRematch:
	special HealParty
	winlosstext Pryce_RematchDefeatText, 0
	loadtrainer PRYCE, 4
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_4
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_4
	startbattle
	reloadmapafterbattle
	end

MahoganyGym_NoRoomForIcyWind:
	closetext
	end

MahoganyGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerSkierRoxanne:
	trainer SKIER, ROXANNE, EVENT_BEAT_SKIER_ROXANNE, SkierRoxanneSeenText, SkierRoxanneBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SkierRoxanneAfterBattleText
	waitbutton
	closetext
	end

TrainerSkierClarissa:
	trainer SKIER, CLARISSA, EVENT_BEAT_SKIER_CLARISSA, SkierClarissaSeenText, SkierClarissaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SkierClarissaAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderRonald:
	trainer BOARDER, RONALD, EVENT_BEAT_BOARDER_RONALD, BoarderRonaldSeenText, BoarderRonaldBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderRonaldAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderBrad:
	trainer BOARDER, BRAD, EVENT_BEAT_BOARDER_BRAD, BoarderBradSeenText, BoarderBradBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderBradAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderDouglas:
	trainer BOARDER, DOUGLAS, EVENT_BEAT_BOARDER_DOUGLAS, BoarderDouglasSeenText, BoarderDouglasBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderDouglasAfterBattleText
	waitbutton
	closetext
	end

MahoganyGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .MahoganyGymGuideWinScript
	writetext MahoganyGymGuideText
	waitbutton
	closetext
	end

.MahoganyGymGuideWinScript:
	writetext MahoganyGymGuideWinText
	waitbutton
	closetext
	end

MahoganyGymStatue:
	checkflag ENGINE_GLACIERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, PRYCE, PRYCE1
	jumpstd GymStatue2Script

PryceText_Intro:
	text "#MON hebben" ; "#MON have many"
	line "vele ervaringen in" ; "experiences in"

	para "hun levens, net" ; "their lives, just "
	line "als wij." ; "like we do. "

	para "Ik heb ook veel" ; "I, too, have seen"
	line "gezien en geleden" ; "and suffered much"
	cont "in mijn leven." ; "in my life."

	para "Omdat ik ouder ben" ; "Since I am your"
	line "dan jij, zal ik" ; "elder, let me show"
	cont "laten zien wat ik" ; "you what I mean."

	para "bedoel. Ik was al" ; "I have been with"
	line "samen met #MON" ; "#MON since"

	para "voordat je ge-" ; "before you were"
	line "boren was." ; "born."

	para "Ik verlies niet" ; "I do not lose"
	line "gemakkelijk." ; "easily."

	para "Ik, PRYCE--de" ; "I, PRYCE--the"
	line "wintertrainer--" ; "winter trainer--"

	para "zal mijn kracht" ; "shall demonstrate"
	line "demonstreren!" ; "my power!"
	done

PryceText_Impressed:
	text "Ah, ik ben onder" ; "Ah, I am impressed"
	line "de indruk van je" ; "by your prowess."
	cont "bekwaamheid." ;

	para "Dankzij je sterke" ; "With your strong"
	line "wil weet ik dat" ; "will, I know you"

	para "je alle obstakels" ; "will overcome all"
	line "in het leven zal" ; "life's obstacles."
	cont "doorstaan." ;

	para "Je bent deze" ; "You are worthy of"
	line "BADGE waardig!" ; "this BADGE!"
	done

Text_ReceivedGlacierBadge:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "GLETSJERBADGE." ; "GLACIERBADGE."
	done

PryceText_GlacierBadgeSpeech:
	text "Die BADGE zal de" ; "That BADGE will"
	line "SPECIALE stats van" ; "raise the SPECIAL"
	cont "#MON verhogen." ; "stats of #MON."

	para "Het laat je #-" ; "It also lets your"
	line "MON ook DRAAIKOLK" ; "#MON use WHIRL-"
	cont "gebruiken om door" ; "POOL to get across"
	cont "echte draaikolken" ; "real whirlpools."
	cont "te zwemmen." ;

	para "En dit… Dit is" ; "And this… This is"
	line "een gift van mij." ; "a gift from me!"
	done

PryceText_IcyWindSpeech:
	text "Die TM bevat" ; "That TM contains"
	line "IJZIGE WIND." ; "ICY WIND."

	para "Het doet schade en" ; "It inflicts damage"
	line "verlaagt snelheid." ; "and lowers speed."

	para "Het laat de hard-" ; "It demonstrates"
	line "heid van winter" ; "the harshness of"
	cont "zien." ; "winter."
	done

PryceText_CherishYourPokemon:
	text "Als ijs en" ; "When the ice and"
	line "sneeuw smelt," ; "snow melt, spring"
	cont "komt de lente." ; "arrives."

	para "Jij en je #MON" ; "You and your #-"
	line "zullen vele" ; "MON will be to-"

	para "jaren samen" ; "gether for many"
	line "zijn." ; "years to come."

	para "Koester je" ; "Cherish your time"
	line "tijd samen!" ; "together!"
	done

PryceRematchText:
	text "Ah, JOHTO"
    line "CHAMPION!"

    para "Your skills"
    line "are indeed"
    cont "remarkable."

    para "I am impressed."

    para "But even now,"
    line "there is much"
    cont "to learn from"
    cont "each other."

    para "I, PRYCE--the"
    line "winter trainer--"

    para "still have a"
    line "few tricks left."

    para "Want to have a"
    line "rematch with me?"
	done

Pryce_RematchDefeatText:
	text "Ah, yet again I'm"
	line "impressed by your"
	cont "prowess."

	para "With your strong"
	line "will, I know you"

	para "will overcome all"
	line "life's obstacles."
	done

BoarderRonaldSeenText:
	text "Ik bevries je" ; "I'll freeze your"
	line "#MON, zodat" ; "#MON, so you"
	cont "je niks kan doen!" ; "can't do a thing!"
	done

BoarderRonaldBeatenText:
	text "Verdorie. Ik" ; "Darn. I couldn't"
	line "kon niets doen." ; "do a thing."
	done

BoarderRonaldAfterBattleText:
	text "Ik denk dat er" ; "I think there's a"
	line "een aanval is die" ; "move a #MON"

	para "een #MON kan" ; "can use while it's"
	line "gebruiken terwijl" ; "frozen."
	cont "het bevroren is." ;
	done

BoarderBradSeenText:
	text "Deze GYM heeft" ; "This GYM has a"
	line "een gladde vloer." ; "slippery floor."

	para "Erg leuk, vind" ; "It's fun, isn't"
	line "je niet?" ; "it?"

	para "Maar hé--we spelen" ; "But hey--we're"
	line "geen spelletjes" ; "not playing games"
	cont "hier!" ; "here!"
	done

BoarderBradBeatenText:
	text "Zie je hoe" ; "Do you see how"
	line "serieus we zijn?" ; "serious we are?"
	done

BoarderBradAfterBattleText:
	text "Deze GYM is top." ; "This GYM is great."
	line "Ik hou van snow-" ; "I love boarding"
	cont "boarden met m'n" ; "with my #MON!"
	cont "#MON!" ;
	done

BoarderDouglasSeenText:
	text "Ik ken het ge-" ; "I know PRYCE's"
	line "heim van PRYCE." ; "secret."
	done

BoarderDouglasBeatenText:
	text "Oké. Ik vertel je" ; "OK. I'll tell you"
	line "PRYCE's geheim." ; "PRYCE's secret."
	done

BoarderDouglasAfterBattleText:
	text "Het geheim achter" ; "The secret behind"
	line "de kracht van" ; "PRYCE's power…"
	cont "PRYCE…" ;

	para "Hij mediteert elke" ; "He meditates under"
	line "dag onder een" ; "a waterfall daily"

	para "waterval om zijn" ; "to strengthen his"
	line "geest en lichaam" ; "mind and body."
	cont "te versterken." ;
	done

SkierRoxanneSeenText:
	text "Om bij onze GYM-" ; "To get to PRYCE,"
	line "LEIDER PRYCE te" ; "our GYM LEADER,"

	para "komen, moet je" ; "you need to think"
	line "nadenken voordat" ; "before you skate."
	cont "je schaatst." ;
	done

SkierRoxanneBeatenText:
	text "Ik zou niet van" ; "I wouldn't lose to"
	line "je verliezen" ; "you in skiing!"
	cont "met skiën!" ;
	done

SkierRoxanneAfterBattleText:
	text "Als je niet nauw-" ; "If you don't skate"
	line "keurig schaatst," ; "with precision,"

	para "kom je niet ver in" ; "you won't get far"
	line "deze GYM." ; "in this GYM."
	;cont "komen." ;
	done

SkierClarissaSeenText:
	text "Kijk naar mijn" ; "Check out my"
	line "parallele bocht!" ; "parallel turn!"
	done

SkierClarissaBeatenText:
	text "Nee! Door jou" ; "No! You made me"
	line "viel ik!" ; "wipe out!"
	done

SkierClarissaAfterBattleText:
	text "Ik had niet moeten" ; "I shouldn't have"
	line "opscheppen over" ; "been bragging"
	cont "mijn geski…" ; "about my skiing…"
	done

MahoganyGymGuideText:
	text "PRYCE is a veteran"
	line "who has trained"

	para "#MON for some"
	line "50 years."

	para "He's got a solid"
	line "lineup of #MON"

	para "to cover whatever"
	line "you bring his way."

	para "Fire is a good"
	line "place to start,"

	para "but watch out"
	line "for the rain!"
	done

MahoganyGymGuideWinText:
	text "PRYCE is heel wat," ; "PRYCE is some-"
	line "maar jij bent" ; "thing, but you're"
	cont "heel wat anders!" ; "something else!"

	para "Dat was een hete" ; "That was a hot"
	line "strijd die de" ; "battle that"

	para "generatiekloof" ; "bridged the gen-"
	line "overbrugde!" ; "eration gap!"
	done

MahoganyGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, MAHOGANY_TOWN, 3
	warp_event  5, 17, MAHOGANY_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, MahoganyGymStatue
	bg_event  6, 15, BGEVENT_READ, MahoganyGymStatue

	def_object_events
	object_event  5,  3, SPRITE_PRYCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyGymPryceScript, -1
	object_event  4,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerSkierRoxanne, -1
	object_event  0, 17, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderRonald, -1
	object_event  9, 17, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerSkierClarissa, -1
	object_event  5,  9, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderBrad, -1
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderDouglas, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyGymGuideScript, -1
