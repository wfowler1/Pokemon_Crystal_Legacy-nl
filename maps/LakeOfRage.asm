	object_const_def
	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_GIO
	const LAKEOFRAGE_GRAMPS
	const LAKEOFRAGE_SUPER_NERD1
	const LAKEOFRAGE_COOLTRAINER_F1
	const LAKEOFRAGE_FISHER1
	const LAKEOFRAGE_FISHER2
	const LAKEOFRAGE_COOLTRAINER_M
	const LAKEOFRAGE_COOLTRAINER_F2
	const LAKEOFRAGE_GYARADOS
	const LAKEOFRAGE_WESLEY
	const LAKEOFRAGE_POKE_BALL1
	const LAKEOFRAGE_POKE_BALL2

LakeOfRage_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; unusable
	scene_script .DummyScene1 ; unusable

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_OBJECTS, .Wesley

.DummyScene0:
	end

.DummyScene1:
	end

.FlyPoint:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	endcallback

.Wesley:
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY
	endcallback

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	endcallback

GioLookUp:
	turn_head UP
	step_end

LakeOfRageGioScript:
	applymovement LAKEOFRAGE_GIO, GioLookUp
	opentext
	writetext GioBeforeText
	waitbutton
	closetext
	end

GioBeforeText:
	text "Niets dan" ; "Nothin' but"
	line "GYARADOS…" ; "GYARADOS…"

	para "Dit is duidelijk" ; "I know it's them."
	line "hun werk." ; 
	done

LakeOfRageLanceScript:
	checkevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	iftrue .AskAgainForHelp
	opentext
	writetext LakeOfRageLanceForcedToEvolveText
	promptbutton
	faceplayer
	faceobject LAKEOFRAGE_GIO, PLAYER
	writetext LakeOfRageLanceIntroText1
	promptbutton
	faceobject LAKEOFRAGE_LANCE, LAKEOFRAGE_GIO
	writetext LakeOfRageLanceIntroText2
	promptbutton
	faceplayer
	writetext LakeOfRageLanceIntroText3
	yesorno
	iffalse .RefusedToHelp
.AgreedToHelp:
	writetext LakeOfRageLanceRadioSignalText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement LAKEOFRAGE_LANCE, LakeOfRageLanceTeleportIntoSkyMovement
	applymovement LAKEOFRAGE_GIO, LakeOfRageLanceTeleportIntoSkyMovement
	disappear LAKEOFRAGE_LANCE
	disappear LAKEOFRAGE_GIO
	clearevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_DECIDED_TO_HELP_LANCE
	setmapscene MAHOGANY_MART_1F, SCENE_MAHOGANYMART1F_LANCE_UNCOVERS_STAIRS
	end

.RefusedToHelp:
	writetext LakeOfRageLanceRefusedText
	waitbutton
	closetext
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	end

.AskAgainForHelp:
	faceplayer
	opentext
	writetext LakeOfRageLanceAskHelpText
	yesorno
	iffalse .RefusedToHelp
	sjump .AgreedToHelp

RedGyarados:
	opentext
	writetext LakeOfRageGyaradosCryText
	pause 15
	cry GYARADOS
	closetext
	loadwildmon GYARADOS, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_SHINY
	startbattle
	ifequal LOSE, .NotBeaten
	disappear LAKEOFRAGE_GYARADOS
.NotBeaten:
	reloadmapafterbattle
	opentext
	giveitem RED_SCALE
	waitsfx
	writetext LakeOfRageGotRedScaleText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setscene 0 ; Lake of Rage does not have a scene variable
	appear LAKEOFRAGE_LANCE
	appear LAKEOFRAGE_GIO
	end

LakeOfRageGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	writetext LakeOfRageGrampsText
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext LakeOfRageGrampsText_ClearedRocketHideout
	waitbutton
	closetext
	end

LakeOfRageSuperNerdScript:
	jumptextfaceplayer LakeOfRageSuperNerdText

LakeOfRageCooltrainerFScript:
	jumptextfaceplayer LakeOfRageCooltrainerFText

LakeOfRageSign:
	jumptext LakeOfRageSignText

MagikarpHouseSignScript:
	opentext
	writetext FishingGurusHouseSignText
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .MagikarpLengthRecord
	waitbutton
	closetext
	end

.MagikarpLengthRecord:
	promptbutton
	special MagikarpHouseSign
	closetext
	end

TrainerFisherAndre:
	trainer FISHER, ANDRE, EVENT_BEAT_FISHER_ANDRE, FisherAndreSeenText, FisherAndreBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherAndreAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherRaymond:
	trainer FISHER, RAYMOND, EVENT_BEAT_FISHER_RAYMOND, FisherRaymondSeenText, FisherRaymondBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherRaymondAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermAaron:
	trainer COOLTRAINERM, AARON, EVENT_BEAT_COOLTRAINERM_AARON, CooltrainermAaronSeenText, CooltrainermAaronBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermAaronAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfLois:
	trainer COOLTRAINERF, LOIS, EVENT_BEAT_COOLTRAINERF_LOIS, CooltrainerfLoisSeenText, CooltrainerfLoisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfLoisAfterBattleText
	waitbutton
	closetext
	end

WesleyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	iftrue WesleyWednesdayScript
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, WesleyNotWednesdayScript
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writetext MeetWesleyText
	promptbutton
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writetext WesleyGivesGiftText
	promptbutton
	verbosegiveitem BLACKBELT_I
	iffalse WesleyDoneScript
	setevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	writetext WesleyGaveGiftText
	waitbutton
	closetext
	end

WesleyWednesdayScript:
	writetext WesleyWednesdayText
	waitbutton
WesleyDoneScript:
	closetext
	end

WesleyNotWednesdayScript:
	writetext WesleyNotWednesdayText
	waitbutton
	closetext
	end

LakeOfRageElixer:
	itemball ELIXER

LakeOfRageTMDetect:
	itemball TM_DETECT

LakeOfRageHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE

LakeOfRageHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY

LakeOfRageHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION

LakeOfRageLanceTeleportIntoSkyMovement:
	teleport_from
	step_end

LakeOfRageLanceForcedToEvolveText:
	text "Dit meer zit vol" ; "This lake is full"
	line "met alleen maar" ; "of GYARADOS but"
	cont "GYARADOS…" ; "nothing else…"

	para "De MAGIKARP worden" ; "So the MAGIKARP"
	line "dus gedwongen te" ; "are being forced"
	cont "evolueren…" ; "to evolve…"
	done

LakeOfRageLanceIntroText1:
	text "Kwam je hier van-" ; "Did you come here"
	line "wege de geruchten?" ; "because of the"
;	cont "rumors?"

	para "Jij bent <PLAYER>?" ; "You're <PLAYER>?"
	line "Ik ben LANCE, een" ; "I'm LANCE, a"
	cont "trainer zoals jij." ; "trainer like you."
	done

LakeOfRageLanceIntroText2:
	text "Deze man lichtte" ; "This man here"
	line "me in over enkele" ; "informed me of"
	cont "geruchten." ; "some rumors."

	para "Dus kwamen we ze" ; "So we came to"
	line "onderzoeken…" ; "investigate…"
	done

LakeOfRageLanceIntroText3:
	text "Ik zag hoe je" ; "I saw the way you"
	line "vocht, <PLAY_G>." ; "battled earlier,"
;	cont "<PLAY_G>."

	para "Ik kan zien dat je" ; "I can tell that"
	line "een zeer vaardige" ; "you're a trainer"

	para "trainer bent." ; "with considerable"
;	line "skill."

	para "Als het niet" ; "If you don't mind,"
	line "stoort, zou je dan" ; "could you help us"
	cont "kunnen helpen met" ; "investigate?"
	cont "ons onderzoek?" ; 
	done

LakeOfRageLanceRadioSignalText:
	text "LANCE: Excellent!" ; "LANCE: Excellent!"

	para "Het lijkt dat de" ; "It seems that the"
	line "MAGIKARP in dit" ; "LAKE's MAGIKARP"

	para "MEER tot evolutie" ; are being forced"
	line "gedwongen worden." ; "to evolve."

	para "Een mysterieus" ; "A mysterious radio"
	line "radiosignaal" ; "broadcast coming"

	para "vanuit MAHOGANY is" ; "from MAHOGANY is"
	line "de oorzaak." ; "the cause."

	para "We wachten daar op" ; "We'll be waiting"
	line "je, <PLAY_G>." ; "for you, <PLAY_G>."
	done

LakeOfRageLanceRefusedText:
	text "Oh…, wel, geef een" ; "Oh… Well, if you"
	line "seintje wanneer je" ; "change your mind,"
	cont "ons wil helpen." ; "please help us."
	done

LakeOfRageLanceAskHelpText:
	text "LANCE: Hm? Ga je" ; "LANCE: Hm? Are you"
	line "ons helpen?" ; "going to help us?"
	done

LakeOfRageGyaradosCryText:
	text "GYARADOS: Gyashaa!"
	done

LakeOfRageGotRedScaleText:
	text "<PLAYER> ontving" ; "<PLAYER> obtained a"
	line "een RODE SCHAAL." ; "RED SCALE."
	done

LakeOfRageGrampsText:
	text "De GYARADOS zijn" ; "The GYARADOS are"
	line "boos!" ; "angry!"

	para "Een slecht teken!" ; "It's a bad omen!"
	done

LakeOfRageGrampsText_ClearedRocketHideout:
	text "Hahah! De MAGI-" ; "Hahah! The MAGI-"
	line "KARP bijten!" ; "KARP are biting!"
	done

LakeOfRageSuperNerdText:
	text "Ik hoorde dat dit" ; "I heard this lake"
	line "meer is gemaakt" ; "was made by ram-"
	cont "door GYARADOS." ; "paging GYARADOS."

	para "Zou er een" ; "I wonder if there"
	line "connectie zijn met" ; "is any connection"

	para "de massa-uitbraak" ; "to their mass out-"
	line "van nu?" ; "break now?"
	done

LakeOfRageCooltrainerFText:
	text "Zag ik het echt?" ; "Did my eyes de-"
	line "Ik spotte een rode" ; "ceive me? I saw a"

	para "GYARADOS middenin" ; "red GYARADOS in"
	line "het MEER…" ; "the LAKE…"

	para "Maar GYARADOS zijn" ; "But I thought"
	line "toch blauw?" ; "GYARADOS were"
	; cont "usually blue?"
	done

FisherAndreSeenText:
	text "Laat me tegen je" ; "Let me battle with"
	line "vechten met mijn" ; "the #MON I just"
	cont "gevangen #MON!" ; "caught!"
	done

FisherAndreBeatenText:
	text "Ik ben een goede" ; "I might be an ex-"
	line "hengelaar, maar" ; "pert angler, but"

	para "vechten kan ik" ; "I stink as a #-"
	line "niet…" ; "MON trainer…"
	done

FisherAndreAfterBattleText:
	text "Ik blijf de beste" ; "I won't lose as an"
	line "hengelaar! Elke" ; "angler! I catch"
	cont "dag vang ik meer." ; "#MON all day."
	done

FisherRaymondSeenText:
	text "Wat ik ook doe," ; "No matter what I"
	line "altijd vang ik" ; "do, all I catch"

	para "weer dezelfde" ; "are the same #-"
	line "#MON…" ; "MON…"
	done

FisherRaymondBeatenText:
	text "Mijn vislijn zit" ; "My line's all"
	line "in de knoop…" ; "tangled up…"
	done

FisherRaymondAfterBattleText:
	text "Hoezo vang ik geen" ; "Why can't I catch"
	line "goede #MON?" ; "any good #MON?"
	done

CooltrainermAaronSeenText:
	text "Als 'n trainer een" ; "If a trainer spots"
	line "andere trainer" ; "another trainer,"

	para "spot, moet je el-" ; "he has to make a"
	line "kaar uitdagen." ; "challenge."

	para "Dat is onze" ; "That is our"
	line "lotsbestemming." ; "destiny."
	done

CooltrainermAaronBeatenText:
	text "Whew…"
	line "Goed gevecht." ; "Good battle."
	done

CooltrainermAaronAfterBattleText:
	text "#MON en hun" ; "#MON and their"
	line "trainer worden" ; "trainer become"

	para "sterker door con-" ; "powerful through"
	line "tinu te vechten." ; "constant battling."
	done

CooltrainerfLoisSeenText:
	text "Wat gebeurde met" ; "What happened to"
	line "de rode GYARADOS?" ; "the red GYARADOS?"

	para "Weg?" ; "It's gone?"

	para "Oh, verdraaid." ; "Oh, darn. I came"
	line "Kwam ik voor niks?" ; "here for nothing?"

	para "Ik weet het--laten" ; "I know--let's"
	line "we vechten!" ; "battle!"
	done

CooltrainerfLoisBeatenText:
	text "Goed bezig!" ; "Good going!"
	done

CooltrainerfLoisAfterBattleText:
	text "Ik bedenk me net," ; "Come to think of"
	line "ooit zag ik een" ; "it, I've seen a"
	cont "roze BUTTERFREE." ; "pink BUTTERFREE."
	done

MeetWesleyText:
	text "WESLEY: Nou, hoe" ; "WESLEY: Well, how"
	line "gaat het?" ; "do you do?"

	para "Gezien het vandaag" ; "Seeing as how it's"
	line "woensdag is," ; "Wednesday today,"

	para "ik ben woensdagse" ; "I'm WESLEY of"
	line "Wesley." ; "Wednesday."
	done

WesleyGivesGiftText:
	text "Fijn je te ont-" ; "Pleased to meet"
	line "moeten. Neem deze" ; "you. Please take a"
	cont "souvenir." ; "souvenir."
	done

WesleyGaveGiftText:
	text "WESLEY: ZWARTE" ; "WESLEY: BLACKBELT"
	line "BAND versterkt je" ; "beefs up the power"
	cont "vecht-aanvallen." ; "of fighting moves."
	done

WesleyWednesdayText:
	text "WESLEY: Gezien je" ; "WESLEY: Since you"
	line "mij vond, moet je" ; "found me, you must"

	para "mijn broers en" ; "have met my broth-"
	line "zussen hebben" ; "ers and sisters."

	para "ontmoet. Of had je" ; "Or did you just"
	line "gewoon geluk?" ; "get lucky?"
	done

WesleyNotWednesdayText:
	text "WESLEY: Vandaag is" ; "WESLEY: Today's"
	line "het niet woensdag." ; "not Wednesday."
	cont "Wat jammer nou." ; "That's too bad."
	done

LakeOfRageSignText:
	text "MEER VAN RAZERNIJ," ; "LAKE OF RAGE,"
	line "ook bekend als" ; "also known as"
	cont "GYARADOS-MEER." ; "GYARADOS LAKE."
	done

FishingGurusHouseSignText:
	text "VISGOEROE'S HUIS" ; "FISHING GURU'S"
	; line "HOUSE"
	done

LakeOfRage_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, 1
	warp_event 27, 31, LAKE_OF_RAGE_MAGIKARP_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 21, 27, BGEVENT_READ, LakeOfRageSign
	bg_event 25, 31, BGEVENT_READ, MagikarpHouseSignScript
	bg_event 11, 28, BGEVENT_ITEM, LakeOfRageHiddenFullRestore
	bg_event  4,  4, BGEVENT_ITEM, LakeOfRageHiddenRareCandy
	bg_event 35,  5, BGEVENT_ITEM, LakeOfRageHiddenMaxPotion

	def_object_events
	object_event 21, 28, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageLanceScript, EVENT_LAKE_OF_RAGE_LANCE
	object_event 19, 28, SPRITE_GIOVANNI_DISGUISE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, LakeOfRageGioScript, EVENT_LAKE_OF_RAGE_LANCE
	object_event 20, 26, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageGrampsScript, -1
	object_event 36, 13, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageSuperNerdScript, -1
	object_event 25, 29, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageCooltrainerFScript, -1
	object_event 30, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 24, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event  4, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 36,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 18, 22, SPRITE_GYARADOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RedGyarados, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	object_event  4,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	object_event  7, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageElixer, EVENT_LAKE_OF_RAGE_ELIXER
	object_event 35,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageTMDetect, EVENT_LAKE_OF_RAGE_TM_DETECT
