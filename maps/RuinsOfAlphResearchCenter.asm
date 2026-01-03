	object_const_def
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST4

RuinsOfAlphResearchCenter_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_RUINSOFALPHRESEARCHCENTER_NOTHING
	scene_script .GetUnownDex ; SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .ScientistCallback

.DummyScene0:
	end

.GetUnownDex:
	sdefer .GetUnownDexScript
	end

.ScientistCallback:
	checkscene
	ifequal SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX, .ShowScientist
	endcallback

.ShowScientist:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 3, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	endcallback

.GetUnownDexScript:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesComputerMovement
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	opentext
	writetext RuinsOfAlphResearchCenterModifiedDexText
	waitbutton
	closetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesPlayerMovement
	opentext
	writetext RuinsOfAlphResearchCenterDexUpgradedText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterLeavesPlayerMovement
	setscene SCENE_RUINSOFALPHRESEARCHCENTER_NOTHING
	special RestartMapMusic
	end

RuinsOfAlphResearchCenterScientist3Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterScientist3_PrinterAvailable
	waitbutton
	closetext
	checkevent EVENT_CAUGHT_ALL_UNOWN
	iffalse .ShowHiddenPowerOnStatsScreen
	end

.ShowHiddenPowerOnStatsScreen
	setevent EVENT_CAUGHT_ALL_UNOWN
	end

RuinsOfAlphResearchCenterScientist1Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkflag ENGINE_UNOWN_DEX
	iftrue .GotUnownDex
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist1Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist1Text_UnownAppeared
	waitbutton
	closetext
	end

.GotUnownDex:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotUnownDex
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotAllUnown
	waitbutton
	closetext
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	end

RuinsOfAlphResearchCenterScientist2Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist2Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist2Text_UnownAppeared
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterScientist2Text_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterComputer:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
.SkipChecking:
	writetext RuinsOfAlphResearchCenterComputerText
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterComputerText_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterPrinter:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
.SkipChecking:
	writetext RuinsOfAlphResearchCenterPrinterText_DoesntWork
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterUnownPrinterText
	waitbutton
	special UnownPrinter
	closetext
	end

RuinsOfAlphResearchCenterPhoto: ; unreferenced
	jumptext RuinsOfAlphResearchCenterProfSilktreePhotoText

RuinsOfAlphResearchCenterBookshelf:
	jumptext RuinsOfAlphResearchCenterAcademicBooksText

RuinsOfAlphResearchCenterApproachesComputerMovement:
	step UP
	step UP
	step LEFT
	turn_head UP
	step_end

RuinsOfAlphResearchCenterApproachesPlayerMovement:
	step DOWN
	step_end

RuinsOfAlphResearchCenterLeavesPlayerMovement:
	step UP
	step_end

FossilScientist:
	faceplayer
	opentext
	checkevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	iftrue .GiveAerodactyl
	checkevent EVENT_GAVE_SCIENTIST_DOME_FOSSIL
	iftrue .GiveKabuto
	checkevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	iftrue .GiveOmanyte
	writetext FossilScientistIntroText
	waitbutton
	loadmenu .MoveMenuHeader
	verticalmenu
	closewindow
	ifequal REVIVE_OLD_AMBER, .OldAmber
	ifequal REVIVE_DOME_FOSSIL, .DomeFossil
	ifequal REVIVE_HELIX_FOSSIL, .HelixFossil
	sjump .No

.OldAmber
	checkitem OLD_AMBER
	iffalse .No
	getmonname STRING_BUFFER_3, AERODACTYL
	writetext FossilScientistMonText
	promptbutton
	readvar VAR_BADGES
	if_greater_than 6, .GotSevenBadges
	writetext MightTakeAWhileText
	yesorno
	iffalse .No
.GotSevenBadges:
	setevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	takeitem OLD_AMBER
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil

.DomeFossil:
	checkitem DOME_FOSSIL
	iffalse .No
	getmonname STRING_BUFFER_3, KABUTO
	writetext FossilScientistMonText
	promptbutton
	setevent EVENT_GAVE_SCIENTIST_DOME_FOSSIL
	takeitem DOME_FOSSIL
	opentext
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil

.HelixFossil:
	checkitem HELIX_FOSSIL
	iffalse .No
	getmonname STRING_BUFFER_3, OMANYTE
	writetext FossilScientistMonText
	promptbutton
	setevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	takeitem HELIX_FOSSIL
	writetext FossilScientistGiveText
	waitbutton
	sjump .GaveScientistFossil

.No
	writetext FossilScientistNoText
	waitbutton
	closetext
	end

.GaveScientistFossil:
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	playsound SFX_WARP_TO
	waitsfx
	pause 35
	sjump FossilScientist

.GiveAerodactyl:
	readvar VAR_BADGES
	if_less_than 7, .NotEnoughBadges
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_OLD_AMBER
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, AERODACTYL
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke AERODACTYL, 25
	closetext
	end

.GiveKabuto:
	readvar VAR_BADGES
	if_less_than 3, .NotEnoughBadges
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_DOME_FOSSIL
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, KABUTO
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke KABUTO, 15
	closetext
	end

.GiveOmanyte:
	readvar VAR_BADGES
	if_less_than 4, .NotEnoughBadges
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	clearevent EVENT_GAVE_SCIENTIST_HELIX_FOSSIL
	writetext FossilScientistDoneText
	promptbutton
	getmonname STRING_BUFFER_3, OMANYTE
	writetext FossilScientistReceiveText
	playsound SFX_CAUGHT_MON
	waitsfx
	waitbutton
	givepoke OMANYTE, 20
	closetext
	end
	
.NotEnoughBadges
	writetext FossilScientistTimeText
	waitbutton
	closetext
	end

.NoRoom:
	writetext FossilScientistPartyFullText
	waitbutton
	closetext
	end

.MoveMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "OLD AMBER@"
	db "DOME FOSSIL@"
	db "HELIX FOSSIL@"
	db "CANCEL@"

RuinsOfAlphResearchCenterPC:
	opentext
	special PokemonCenterPC
	closetext
	end

FossilScientistIntroText:
	text "Hiya!"

	para "I am important"
	line "doctor!"

	para "I study here rare"
	line "#MON fossils!"

	para "You! Have you a"
	line "fossil for me?"
	done

MightTakeAWhileText:
	text "But this one"
	line "could take a"
	cont "long time."

	para "Are you sure"
	line "you don't want"
	cont "any other fossils"
	cont "revived first?"
	done

FossilScientistNoText:
	text "No! Is too bad!"

	para "You come again!"
	done

FossilScientistPartyFullText:
	text "No! Is too bad!"

	para "Your party is"
	line "already full!"
	done

FossilScientistTimeText:
	text "Wow this one is"
	line "quite complex..."

	para "I take a little"
	line "time!"

	para "You go for walk a"
	line "little while!"
	done

FossilScientistDoneText:
	text "Where were you?"

	para "Your fossil is"
	line "back to life!"
	done

FossilScientistMonText:
	text "Oh! That is"
	line "a fossil!"

	para "It is fossil of"
	line "@"
	text_ram wStringBuffer3
	text ", a"

	para "#MON that is"
	line "already extinct!"

	para "My Resurrection"
	line "Machine will make"
	cont "that #MON live"
	cont "again!"
	done

FossilScientistGiveText:
	text "So! You hurry and"
	line "give me that!"

	para "<PLAYER> handed"
	line "over the fossil."
	done

FossilScientistReceiveText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

RuinsOfAlphResearchCenterModifiedDexText:
	text "Klaar!" ; "Done!"

	para "Ik heb je #DEX" ; "I modified your"
	line "aangepast." ; "#DEX."

	para "Hij heeft nu een" ; "I added an"
	line "nieuwe modus voor" ; "optional #DEX"
	cont "UNOWN-gegevens."

	; para "to store UNOWN"
	; line "data."

	para "Hij ordent ze in" ; "It records them in"
	line "de volgorde waarin" ; "the sequence that"
	cont "ze zijn gevangen." ; "they were caught."
	done

RuinsOfAlphResearchCenterDexUpgradedText:
	text "De #DEX" ; "<PLAYER>'s #DEX"
	line "is geüpgraded." ; "was upgraded."
	done

RuinsOfAlphResearchCenterScientist3Text:
	text "De UNOWN die je" ; "The UNOWN you"
	line "vangt worden alle-" ; "catch will all be"
	cont "maal vastgelegd." ; "recorded."

	para "Je kunt zien hoe-" ; "Check to see how"
	line "veel soorten er" ; "many kinds exist."
	cont "bestaan."
	done

RuinsOfAlphResearchCenterScientist3_PrinterAvailable:
	text "Heb je alle" ; "You caught all the"
	line "soorten UNOWN" ; "UNOWN variations?"
	cont "gevangen?"

	para "Die is een grote" ; "That's a great"
	line "prestatie!" ; "achievement!"

	para "Hier vind je de" ; "I've set up the"
	line "printer voor" ; "printer here for"
	cont "UNOWN." ; "handling UNOWN."

	para "Gebruik hem maar" ; "Feel free to use"
	line "wanneer je wil." ; "it anytime."
	done

RuinsOfAlphResearchCenterScientist1Text:
	text "De RUÏNES zijn" ; "The RUINS are"
	line "ongeveer 1500 jaar" ; "about 1500 years"
	cont "oud." ; "old."

	para "Maar we weten niet" ; "But it's not known"
	line "waarom ze gebouwd" ; "why they were"
	cont "zijn--of door wie." ; "built--or by whom."
	done

RuinsOfAlphResearchCenterScientist1Text_GotUnownDex:
	text "Ik vraag me af" ; "I wonder how many"
	line "hoeveel soorten" ; "kinds of #MON"
	cont "#MON er in de" ; "are in the RUINS?"
	cont "RUÏNES wonen?"
	done

RuinsOfAlphResearchCenterScientist1Text_UnownAppeared:
	text "#MON verschenen" ; "#MON appeared"
	line "in de RUÏNES?" ; "in the RUINS?"

	para "Dat is ongeloof-" ; "That's incredible"
	line "lijk nieuws!" ; "news!"

	para "We moeten het" ; "We'll need to"
	line "onderzoeken." ; "investigate this."
	done

RuinsOfAlphResearchCenterScientist1Text_GotAllUnown:
	text "Dankzij jouw werk," ; "Our investigation,"
	line "ontdekt ons onder-" ; "with your help, is"

	para "zoek steeds meer" ; "giving us insight"
	line "over de RUÏNES." ; "into the RUINS."

	para "De RUÏNES lijken" ; "The RUINS appear"
	line "te zijn gebouwd" ; "to have been built"

	para "als leefgebied" ; "as a habitat for"
	line "voor #MON." ; "#MON."
	done

RuinsOfAlphResearchCenterScientist2Text:
	text "Er zijn vreemde" ; "There are odd pat-"
	line "patronen op de" ; "terns drawn on the"

	para "muren van de" ; "walls of the"
	line "RUÏNES." ; "RUINS."

	para "Dat moeten de ant-" ; "They must be the"
	line "woorden zijn op" ; "keys for unravel-"
	cont "het mysterie van" ; "ing the mystery"
	cont "de RUÏNES." ; "of the RUINS."
	done

RuinsOfAlphResearchCenterScientist2Text_UnownAppeared:
	text "De vreemde #MON" ; "The strange #-"
	line "die je in de" ; "MON you saw in the"
	; cont "RUINS?"

	para "RUÏNES zag lijken" ; "They appear to be"
	line "op de patronen op" ; "very much like the"

	para "de muren daar." ; "drawings on the"
	; line "muren daar." ; "walls there."

	para "Hmm…"

	para "Er moeten veel" ; "That must mean"
	line "verschillende" ; "there are many"
	cont "soorten zijn." ; "kinds of them…"
	done

RuinsOfAlphResearchCenterUnusedText1: ; unreferenced
	text "We denken dat iets" ; "We think something"
	line "ervoor zorgde dat" ; "caused the cryptic"

	para "cryptische patro-" ; "patterns to appear"
	line "nen in de RUÏNES " ; "in the RUINS."
	cont "verschenen."

	para "We richten ons" ; "We've focused our"
	line "onderzoek daarop." ; "studies on that."
	done

RuinsOfAlphResearchCenterUnusedText2: ; unreferenced
	text "Volgens mijn" ; "According to my"
	line "onderzoek versche-" ; "research…"

	para "nen de mysterieuze" ; "Those mysterious"
	line "patronen toen het" ; "patterns appeared"

	para "#MONCENTRUM" ; "when the #COM"
	line "werd gebouwd." ; "CENTER was built."

	para "Het betekent vast" ; "It must mean that"
	line "dat radiogolven" ; "radio waves have"

	para "een zekere rol" ; "some sort of a"
	line "spelen…" ; "link…"
	done

RuinsOfAlphResearchCenterScientist2Text_GotAllUnown:
	text "Waarom verschenen" ; "Why did those"
	line "de oude patronen" ; "ancient patterns"

	para "juist nu op de" ; "appear on the wall"
	line "muren?" ; "now?"

	para "Nog een" ; "The mystery"
	line "mysterie…" ; "deepens…"
	done

RuinsOfAlphResearchCenterComputerText:
	text "RUÏNES VAN ALF" ; "RUINS OF ALPH"

	para "Onderzoeksjaar 10" ; "Exploration"
	; line "Year 10"
	done

RuinsOfAlphResearchCenterComputerText_GotAllUnown:
	text "Mysterieuze" ; "Mystery #MON"
	line "#MON"
	cont "Naam: UNOWN" ; "Name: UNOWN"

	para "{d:NUM_UNOWN} soorten" ; "A total of {d:NUM_UNOWN}"
	line "ontdekt." ; "kinds found."
	done

RuinsOfAlphResearchCenterPrinterText_DoesntWork:
	text "I wonder what"
	line "this machine does."
	done

RuinsOfAlphResearchCenterUnownPrinterText:
	text "Je mag UNOWN" ; "UNOWN may be"
	line "afdrukken." ; "printed out."
	done

RuinsOfAlphResearchCenterProfSilktreePhotoText:
	text "Het is een foto" ; "It's a photo of"
	line "van de oprichter" ;  "the RESEARCH"

	para "van de ONDERZOEK-" ; "CENTER'S founder,"
	line "SCENTRUM," ; "PROF.SILKTREE."
	cont "PROF. SILKTREE."
	done

RuinsOfAlphResearchCenterAcademicBooksText:
	text "Er liggen veel" ; "There are many"
	line "academische" ; "academic books."
	cont "boeken."

	para "Oude RUÏNES…" ; "Ancient Ruins…"
	line "Mysteries van de" ; "Mysteries of the"
	cont "Ouden…" ; "Ancients…"
	done

RuinsOfAlphResearchCenter_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, RUINS_OF_ALPH_OUTSIDE, 6
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 6

	def_coord_events

	def_bg_events
	bg_event  6,  5, BGEVENT_READ, RuinsOfAlphResearchCenterBookshelf
	bg_event  3,  4, BGEVENT_READ, RuinsOfAlphResearchCenterPC
	bg_event  7,  1, BGEVENT_READ, RuinsOfAlphResearchCenterPrinter

	def_object_events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist1Script, -1
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist2Script, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist3Script, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	object_event  7,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 2, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FossilScientist, -1
