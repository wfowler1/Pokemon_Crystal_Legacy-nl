	object_const_def
	const GOLDENRODGYM_WHITNEY
	const GOLDENRODGYM_LASS1
	const GOLDENRODGYM_LASS2
	const GOLDENRODGYM_BEAUTY1
	const GOLDENRODGYM_BEAUTY2
	const GOLDENRODGYM_GYM_GUIDE

GoldenrodGym_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_GOLDENRODGYM_NOTHING
	scene_script .DummyScene1 ; SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

GoldenrodGymWhitneyScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .FightDone
	opentext
	writetext WhitneyBeforeText
	waitbutton
	closetext
	winlosstext WhitneyShouldntBeSoSeriousText, 0
	loadtrainer WHITNEY, WHITNEY1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_WHITNEY1
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_WHITNEY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_MADE_WHITNEY_CRY
	setscene SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	setevent EVENT_BEAT_LASS_CARRIE
	setevent EVENT_BEAT_LASS_BRIDGET
.FightDone:
	opentext
	checkevent EVENT_MADE_WHITNEY_CRY
	iffalse .StoppedCrying
	writetext WhitneyYouMeanieText
	waitbutton
	closetext
	end

.StoppedCrying:
	checkevent EVENT_GOT_TM45_ATTRACT
	iftrue .GotAttract
	checkflag ENGINE_PLAINBADGE
	iftrue .GotPlainBadge
	writetext WhitneyWhatDoYouWantText
	promptbutton
	waitsfx
	writetext PlayerReceivedPlainBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_PLAINBADGE
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	loadmem wLevelCap, 25 ; update level cap for hard mode
.DontUpdateBadge
	readvar VAR_BADGES
	scall GoldenrodGymActivateRockets
.GotPlainBadge:
	writetext WhitneyPlainBadgeText
	promptbutton
	verbosegiveitem TM_ATTRACT
	iffalse .NoRoomForAttract
	setevent EVENT_GOT_TM45_ATTRACT
	writetext WhitneyAttractText
	waitbutton
	closetext
	end

.GotAttract:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotBeatE4
	writetext WhitneyRematchText
	yesorno
	iftrue .WhitneyRematch
	sjump .NoRoomForAttract
.NotBeatE4
	writetext WhitneyGoodCryText
	waitbutton
.NoRoomForAttract:
	closetext
	end

.WhitneyRematch:
	special HealParty
	winlosstext Whitney_RematchDefeatText, 0
	loadtrainer WHITNEY, 2
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	end

GoldenrodGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerLassCarrie:
	trainer LASS, CARRIE, EVENT_BEAT_LASS_CARRIE, LassCarrieSeenText, LassCarrieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassCarrieAfterBattleText
	waitbutton
	closetext
	end

WhitneyCriesScript:
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS2, 15
	applymovement GOLDENRODGYM_LASS2, BridgetWalksUpMovement
	turnobject PLAYER, DOWN
	opentext
	writetext BridgetWhitneyCriesText
	waitbutton
	closetext
	applymovement GOLDENRODGYM_LASS2, BridgetWalksAwayMovement
	setscene SCENE_GOLDENRODGYM_NOTHING
	clearevent EVENT_MADE_WHITNEY_CRY
	end

TrainerLassBridget:
	trainer LASS, BRIDGET, EVENT_BEAT_LASS_BRIDGET, LassBridgetSeenText, LassBridgetBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassBridgetAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyVictoria:
	trainer BEAUTY, VICTORIA, EVENT_BEAT_BEAUTY_VICTORIA, BeautyVictoriaSeenText, BeautyVictoriaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyVictoriaAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautySamantha:
	trainer BEAUTY, SAMANTHA, EVENT_BEAT_BEAUTY_SAMANTHA, BeautySamanthaSeenText, BeautySamanthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautySamanthaAfterBattleText
	waitbutton
	closetext
	end

GoldenrodGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .GoldenrodGymGuideWinScript
	opentext
	writetext GoldenrodGymGuideText
	waitbutton
	closetext
	end

.GoldenrodGymGuideWinScript:
	opentext
	writetext GoldenrodGymGuideWinText
	waitbutton
	closetext
	end

GoldenrodGymStatue:
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, WHITNEY, WHITNEY1
	jumpstd GymStatue2Script

BridgetWalksUpMovement:
	step LEFT
	turn_head UP
	step_end

BridgetWalksAwayMovement:
	step RIGHT
	turn_head LEFT
	step_end

WhitneyBeforeText:
	text "Hoi! Ik ben" ; "Hi! I'm WHITNEY!"
	line "WHITNEY!" ; 

	para "Iedereen hield" ; "Everyone was into"
	line "van #MON, dus" ; "#MON, so I got"
	cont "ik nu ook!" ; "into it too!"

	para "#MON zijn" ; "#MON are"
	line "superschattig!" ; "super-cute!"

	para "Wil je vechten?" ; "You want to bat-"
	line "Ik waarschuw" ; "tle? I'm warning"
	cont "je--ik ben goed!" ; "you--I'm good!"
	done

WhitneyShouldntBeSoSeriousText:
	text "Snik…" ; "Sob…"

	para "…Waaaaaaah!"
	line "Je bent gemeen!" ; "You're mean!"

	para "Je moet niet zo" ; "You shouldn't be"
	line "serieus zijn! Jij…" ; "so serious! You…"
	cont "jij kleuter, jij!" ; "you child, you!"
	done

WhitneyYouMeanieText:
	text "Waaaaah!"

	para "Waaaaah!"

	para "…Snotter, hik…" ; "…Snivel, hic…"
	line "…Jij gemenerd!" ; "…You meanie!"
	done

WhitneyWhatDoYouWantText:
	text "…Snotter…" ; "…Sniff…"

	para "Wat? Wat wil je?" ; "What? What do you"
	line "Een BADGE?" ; "want? A BADGE?"

	para "Oh, juist." ; "Oh, right."
	line "Vergeten. Hier is" ; "I forgot. Here's"
	cont "de SIMPELBADGE." ; "PLAINBADGE."
	done

PlayerReceivedPlainBadgeText:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "SIMPELBADGE." ; "PLAINBADGE."
	done

WhitneyPlainBadgeText:
	text "SIMPELBADGE laat" ; "PLAINBADGE lets"
	line "je #MON KRACHT" ; "your #MON use"

	para "gebruiken buiten" ; "STRENGTH outside"
	line "gevechten." ; "of battle."

	para "Het verhoogt" ; "It also boosts"
	line "ook je #MON's" ; "your #MON's"
	cont "SNELHEID." ; "SPEED."

	para "Oh, je mag dit ook" ; "Oh, you can have"
	line "houden!" ; "this too!"
	done

WhitneyAttractText:
	text "Het is VERLEID!" ; "It's ATTRACT!"
	line "Het gebruikt" ; "It makes full use"

	para "de charme van" ; "of a #MON's"
	line "een #MON." ; "charm."

	para "Is het niet" ; "Isn't it just per-"
	line "perfect voor een" ; "fect for a cutie"
	cont "schatje als ik?" ; "like me?"
	done

WhitneyGoodCryText:
	text "Ah, that was a"
	line "good cry!"
	done

WhitneyRematchText:
	text "Hi! It's you!"

    para "Wow, JOHTO"
    line "CHAMPION now?"

    para "You really are"
    line "amazing!"

    para "I want to see"
    line "how strong you"
    cont "are."

	para "Want to have a"
	line "rematch with me?"
	done

Whitney_RematchDefeatText:
	text "Waaaaah!"

	para "Waaaaah!"

	para "…Snivel, hic…"
	line "…You meanie!"
	done

LassCarrieSeenText:
	text "Laat je niet fop-" ; "Don't let my"
	line "pen door m'n" ; "#MON's cute"

	para "#MON's schattige" ; "looks fool you."
	line "uiterlijk. Ze" ; "They can whip you!"
	cont "kunnen flink" ; 
	cont "uithalen!" ;
	done

LassCarrieBeatenText:
	text "Chips… Ik dacht" ; "Darn… I thought"
	line "dat je zwak was…" ; "you were weak…"
	done

LassCarrieAfterBattleText:
	text "Denken m'n #MON" ; "Do my #MON"
	line "dat ik schattig" ; "think I'm cute?"
	cont "ben?" ;
	done

LassBridgetSeenText:
	text "Ik vind schattige" ; "I like cute #-"
	line "#MON leuker dan" ; "MON better than"
	cont "sterke #MON." ; "strong #MON."

	para "Maar ik heb sterke" ; "But I have strong"
	line "én schattige" ; "and cute #MON!"
	cont "#MON!" ; 
	done

LassBridgetBeatenText:
	text "Oh, nee, nee!" ; "Oh, no, no, no!"
	done

LassBridgetAfterBattleText:
	text "Ik probeer WHITNEY" ; "I'm trying to beat"
	line "te verslaan, maar…" ; "WHITNEY, but…"
	cont "'t is deprimerend." ; "It's depressing."

	para "Ik ben oké! Als ik" ; "I'm okay! If I"
	line "verlies, doe ik" ; "lose, I'll just"

	para "volgende keer ge-" ; "try harder next"
	line "woon beter m'n" ; "time!"
	cont "best!" ; 
	done

BridgetWhitneyCriesText:
	text "Oh nee. Je hebt" ; "Oh, no. You made"
	line "WHITNEY aan het" ; "WHITNEY cry."
	cont "huilen gemaakt." ; 

	para "Het is oké. Ze" ; "It's OK. She'll"
	line "stopt snel. Ze" ; "stop soon. She"

	para "huilt altijd als" ; "always cries when"
	line "ze verliest." ; "she loses."
	done

BeautyVictoriaSeenText:
	text "Oh, je bent zo'n" ; "Oh, you are a cute"
	line "schattige kleine" ; "little trainer! "
	cont "trainer!" ; 

	para "Je bent leuk, maar" ; "I like you, but I"
	line "ik hou me niet in!" ; "won't hold back!"
	done

BeautyVictoriaBeatenText:
	text "Eens zien… Oeps," ; "Let's see… Oops,"
	line "het is voorbij?" ; "it's over?"
	done

BeautyVictoriaAfterBattleText:
	text "Wow, je moet wel" ; "Wow, you must be"
	line "goed zijn om me te" ; "good to beat me!"
	cont "verslaan! Ga zo" ; "Keep it up!"
	cont "door!" ; 
	done

BeautySamanthaSeenText:
	text "Doe je best, of" ; "Give it your best"
	line "anders haal ik" ; "shot, or I'll take"
	cont "je neer!" ; "you down!"
	done

BeautySamanthaBeatenText:
	text "Nee! Oh, MEOWTH," ; "No! Oh, MEOWTH,"
	line "het spijt me zo!" ; "I'm so sorry!"
	done

BeautySamanthaAfterBattleText:
	text "Ik heb MEOWTH" ; "I taught MEOWTH"
	line "aanvallen geleerd" ; "moves for taking"
	cont "om elk type aan" ; 
	cont "te pakken…" ; "on any type…"
	done

GoldenrodGymGuideText:
	text "Yo! CHAMP in"
	line "making!"

	para "This GYM is home"
	line "to WHITNEY, the"
	cont "master of NORMAL-"
	cont "type #MON."

	para "Be cautious of"
	line "her cute team."

	para "That little teddy"
	line "bear of hers might"
	cont "be adorable,"
	
	para "but I've seen it"
	line "shatter rocks."
	
	para "Check ROUTE 34"
	line "if you need a"
	cont "FIGHTING-type."
	done

GoldenrodGymGuideWinText:
	text "Je hebt gewonnen?" ; "You won? Great! I"
	line "Ik was druk met de" ; "was busy admiring"
	cont "dames bewonderen." ; "the ladies here."
	done

GoldenrodGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, GOLDENROD_CITY, 1
	warp_event  3, 17, GOLDENROD_CITY, 1

	def_coord_events
	coord_event  8,  5, SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING, WhitneyCriesScript

	def_bg_events
	bg_event  1, 15, BGEVENT_READ, GoldenrodGymStatue
	bg_event  4, 15, BGEVENT_READ, GoldenrodGymStatue

	def_object_events
	object_event  8,  3, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymWhitneyScript, -1
	object_event  9, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerLassCarrie, -1
	object_event  9,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerLassBridget, -1
	object_event  0,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautyVictoria, -1
	object_event 19,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBeautySamantha, -1
	object_event  5, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymGuideScript, -1
