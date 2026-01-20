	object_const_def
	const EARLSPOKEMONACADEMY_EARL
	const EARLSPOKEMONACADEMY_YOUNGSTER1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID2
	const EARLSPOKEMONACADEMY_YOUNGSTER2
	const EARLSPOKEMONACADEMY_POKEDEX

EarlsPokemonAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

AcademyEarl:
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	faceplayer
	opentext
	writetext AcademyEarlIntroText
	yesorno
	iffalse .Part1
	writetext AcademyEarlTeachHowToWinText
	yesorno
	iffalse .Done
.Part1:
	writetext AcademyEarlTeachMoreText
	yesorno
	iffalse .Done
	writetext AcademyEarlTeachHowToRaiseWellText
	waitbutton
	closetext
	end

.Done:
	writetext AcademyEarlNoMoreToTeachText
	waitbutton
	closetext
	end

EarlsPokemonAcademyYoungster1Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster1Text

EarlsPokemonAcademyGameboyKid1Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid1Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
	end

EarlsPokemonAcademyGameboyKid2Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid2Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID2, DOWN
	end

EarlsPokemonAcademyYoungster2Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster2Text

AcademyBlackboard:
	opentext
	writetext AcademyBlackboardText
.Loop:
	loadmenu .BlackboardMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .Poison
	ifequal 2, .Paralysis
	ifequal 3, .Sleep
	ifequal 4, .Burn
	ifequal 5, .Freeze
	closetext
	end

.Poison:
	writetext AcademyPoisonText
	waitbutton
	sjump .Loop

.Paralysis:
	writetext AcademyParalysisText
	waitbutton
	sjump .Loop

.Sleep:
	writetext AcademySleepText
	waitbutton
	sjump .Loop

.Burn:
	writetext AcademyBurnText
	waitbutton
	sjump .Loop

.Freeze:
	writetext AcademyFreezeText
	waitbutton
	sjump .Loop

.BlackboardMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 11, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	dn 3, 2 ; rows, columns
	db 5 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "GIF@" ; "PSN@"
	db "VLM@" ; "PAR@"
	db "SLP@"
	db "BRN@"
	db "BVR@" ; "FRZ@"
	db "UIT@"; "QUIT@"

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalse .Done
	writetext AcademyNotebookText1
	yesorno
	iffalse .Done
	writetext AcademyNotebookText2
	yesorno
	iffalse .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	closetext
	end

AcademyStickerMachine: ; unreferenced
	jumptext AcademyStickerMachineText

AcademyBookshelf:
	jumpstd DifficultBookshelfScript

AcademyEarlSpinMovement:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

AcademyEarlIntroText:
	text "EARL, ik ben!" ; "EARL, I am!"

	para "Prachtig zijn" ; "Wonderful are"
	line "#MON, ja!" ; "#MON, yes!"

	para "Leren zal ik je om" ; "Teach you I will"
	line "betere trainer te" ; "to be a better"
	cont "worden!" ; "trainer!"

	para "Wat wil je graag" ; "What you want to"
	line "weten? Wil je" ; "know? Want to be"
	cont "winnaar worden?" ; "a winner is you?"
	done

AcademyEarlTeachHowToWinText:
	text "Goed! Je leren," ; "Good! Teach you,"
	line "zal ik!" ; "I will!"

	para "Bij gevecht, eerst" ; "In battle, #MON"
	line "#MON bovenaan" ; "top on list jump"
	cont "lijst aan beurt!" ; "out first!"

	para "Verander volgorde" ; "Change order in"
	line "in lijst, maakt" ; "list, make battle"
	cont "vechten makkelijk!" ; "easy, maybe!"

	para "Wil je meer van" ; "More from me you"
	line "mij weten?" ; "want to hear?"
	done

AcademyEarlTeachMoreText:
	text "Dus, wil je weten" ; "So, want to know"
	line "hoe je #MON" ; "how to raise"
	cont "goed opvoedt?" ; "#MON well?"
	done

AcademyEarlTeachHowToRaiseWellText:
	text "Prima! Leren, zal" ; "Fine! Teach you,"
	line "ik je!" ; "I will!"

	para "Als #MON even" ; "If #MON come"
	line "in gevecht zijn," ; "out in battle even"

	para "krijgen ze ook" ; "briefly, some EXP."
	line "ERV. punten." ; "Points it gets."

	para "Zet zwakke #MON" ; "At top of list put"
	line "bovenaan lijst." ; "weak #MON."

	para "Wissel snel in" ; "Switch in battle"
	line "gevecht!" ; "quick!"

	para "Op die manier," ; "This way, weak"
	line "zwakke #MON" ; "#MON strong"
	cont "worden sterk!" ; "become!"
	done

AcademyEarlNoMoreToTeachText:
	text "Oh! Slimme student" ; "Oh! Smart student"
	line "ben jij! Niks meer" ; "you are! Nothing"
	cont "kan ik je leren!" ; "more do I teach!"

	para "Goed voor #MON" ; "Good to #MON"
	line "moet jij zijn!" ; "you must be!"
	done

EarlsPokemonAcademyYoungster1Text:
	text "#MON die enkel" ; "#MON previously"
	line "na ruilen" ; "thought to only"
	cont "evolueren, kunnen" ; "evolve through"

	para "het blijkbaar ook" ; "trade can evolve"
	line "door te groeien." ; "through leveling."

	para "MACHOKE en" ; MACHOKE and"
	line "GRAVELER evolueren" ; GRAVELER evolve"
	cont "op LVL 38. KADABRA" ; "at LVL 38, while"
	
	para "en HAUNTER evo-" ; "KADABRA and"
	line "lueren op LVL 42." ; HAUNTER evolve"
;	cont "at LVL 42."

	para "Enkele voorwerpen," ; "Some items, like"
	line "zoals de METALEN JAS" ; "the METAL COAT,"
	
	para "kunnen blijbaar" ; "have also been"
	line "#MON laten evo-" ; "found to evolve"
	cont "lueren net als" ; certain #MON"
	
	para "evolutiestenen." ; "similarly to"
;	line "evolution stones."
	
	para "Een BAKSTEENSTUK," ; "A BRICK PIECE"
	line "overhandigd aan" ; "given to a"
	cont "een TYROGUE," ; "TYROGUE has led"
	
	para "leidde tot de" ; "to a new #MON"
	line "ontdekking van een" ; discovery."
	cont "nieuwe #MON." ; 
	done

EarlsPokemonAcademyGameboyKid1Text:
	text "Het recent ont-" ; "The newly discov-"
    line "dekte DUISTER-type" ;ered DARK-type"
    cont "veroorzaakt" ; "deals physical"
    cont "fysieke schade." ; "damage."

    para "Het GEEST-type" ; "The GHOST-type"
    line "veroorzaakt" ; "deals special"
    cont "speciale schade." ; damage."

    para "De aanval SPIJKER-" ; "The move SPIKE"
    line "KANON, ooit inge-" ; "CANNON, once"
    cont "deeld als NORMAAL-" ; "thought to be a"

    para "type aanval, bleek" ; "NORMAL-type move,"
    line "een STAAL-type" ; is actually a"
    cont "aanval te zijn." ; STEEL-type move."
    done

EarlsPokemonAcademyGameboyKid2Text:
	text "Doordat trainers" ; "As trainers ex-"
	line "verbeterden, zijn" ; pand their skills,"

	para "vele aanvallen nu" ; Many moves are now"
    line "preciezer dan" ; "more accurate than"
    cont "voorheen geweten," ; "previously known,"

	para "en sommige die als" ; "and some that were"
    line "zwak beschouwd" ; "once thought to be"
	cont "werden zijn" ; "underpowered have"

    para "sterker geworden." ; seen increases"
;    line "to their power."
	
	para "Met name het" ; Most notably, the"
    line "INSECT-type is nu" ; "BUG-type is now"
    cont "veel vatbaarder in" ; far more viable in"
    cont "gevechten." ; "battle."

    para "Het VECHT-type zag" ; "The FIGHTING-type"
    line "ook een sterke" ; "has also improved"
    cont "verbetering over" ; dramatically over"

    para "de laatste drie" ; "the last three"
    line "jaar." ; "years."
    done

EarlsPokemonAcademyYoungster2Text:
	text "Als #MON groei-" ; "As #MON"
	line "en, doen hun stats" ; "continue to grow,"
	cont "dat ook." ; "as do their stats."
	
	para "Ze zijn nog steeds" ; "While still rec-"
    line "herkenbaar, maar" ; "ognizable, some"
    cont "sommige #MON"; "#MON once"
	
	para "ooit beschouwd als" ; "thought to be"
    line "onvatbaar, zagen" ; "nonviable have"
    cont "kleine stat" ; "seen small stat"
	
	para "toenames van 5-20" ; "increases of"
    line "basispunten." ; "5-20 base points."

	para "ARIADOS bijvoor-" ; "ARIADOS in par-"
    line "beel werd een pak" ; "ticular has become"
	cont "sneller, met 80" ; "much faster, with"

	para "als nieuwe basis-" ; "a new base SPEED"
    line "SNELHEID." ; "stat of 80."

    para "Vele #MON kun-" ; "Many #MON can"
    line "nen nieuwe" ; "learn moves they"
    cont "aanvallen leren." ; "couldn't before."

	para "Nu kunnen bijna"; "Now, nearly all"
	line "alle #MON aan-" ; "#MON learn"
	cont "vallen van hun" ; "multiple moves of"

	para "eigen type leren" ; "its own type via"
    line "door te groeien." ; "level-up."
	
	para "Velen blijken ook" ; "Many also seem"
	line "aanvallen eerder" ; "to be learning"
	cont "te leren dan" ; "moves sooner"
	
	para "voordien." ; "than they once"
;	line "did."
	
	para "Wees gewaarschuwd:" ; "Be aware that your"
    line "andere trainers" ; "opponents now use"
    cont "gebruiken nu ook" ; "teams with better"
    cont "teams met betere" ; "type coverage,"

    para "dekking, verwacht" ; "so expect a much"
    line "je aan een meer" ; "more challenging"
    cont "uitdagende reis." ; "journey ahead."
    done

AcademyBlackboardText:
	text "Het krijtbord be-" ; "The blackboard"
	line "schrijft #MON-" ; "describes #MON"

	para "statuswijzigingen" ; "status changes in"
	line "bij gevechten." ; "battle."
	done

AcademyBlackboardText2: ; unreferenced
	text "Waar over lezen?" ; "Read which topic?"
	done

AcademyPoisonText:
	text "Een vergiftigde" ; "If poisoned, a"
	line "#MON verliest" ; "#MON steadily"
	cont "steeds weer LP." ; "loses HP."

	para "Gif blijft hangen" ; "Poison lingers"
	line "na een gevecht," ; "after the battle,"

	para "en je verliest LP" ; "and HP is lost as"
	line "als je loopt." ; "you walk."

	para "Je geneest het met" ; "To cure it, use an"
	line "een TEGENGIF." ; "ANTIDOTE."
	done

AcademyParalysisText:
	text "Verlamming ver-" ; "Paralysis reduces"
	line "traagt en voor-" ; "speed and may"
	cont "komt soms beweging" ; "prevent movement."

	para "Het blijft hangen" ; "It remains after"
	line "dus gebruik een" ; "battle, so use"
	cont "VERLAMGENEZER." ; "a PARLYZ HEAL."
	done

AcademySleepText:
	text "Een slapende #-" ; "If asleep, your"
	line "MON kan niet" ; "#MON can't make"
	cont "aanvallen." ; "a move."

	para "Na een gevecht" ; "A sleeping #MON"
	line "wordt de #MON" ; "doesn't wake up"
	cont "niet wakker." ; "after battle."

	para "Wekken kan met" ; "Wake it up with"
	line "een ONTWAKER." ; "an AWAKENING."
	done

AcademyBurnText:
	text "Een brandwond kost" ; "A burn steadily"
	line "iedere beurt LP." ; "consumes HP."

	para "Het verlaagt ook" ; "It also reduces"
	line "je aanvalskracht." ; "attack power."

	para "Je #MON blijft" ; "A burn lingers"
	line "achteraf verbrand." ; "after battle."

	para "Gebruik BRANDZALF" ; "Use a BURN HEAL as"
	line "om te genezen." ; "the cure."
	done

AcademyFreezeText:
	text "Een bevroren #-" ; "If your #MON is"
	line "MON kan niks doen" ; "frozen, it can't"
	cont "in een gevecht." ; "do a thing."

	para "Achteraf blijft" ; "It remains frozen"
	line "deze bevroren." ; "after battle."

	para "Ontdooi dan met" ; "Thaw it out with"
	line "een IJSGENEZER." ; "an ICE HEAL."
	done

AcademyNotebookText:
	text "He, het notitie-" ; "It's this kid's"
	line "blok van dat kind…" ; "notebook…"

	para "Vang #MON met" ; "Catch #MON"
	line "#BALLEN." ; "using # BALLS."

	para "Je kunt er tot zes" ; "Up to six can be"
	line "met je meenemen." ; "in your party."

	para "Blijven lezen?" ; "Keep reading?"
	done

AcademyNotebookText1:
	text "Voor je een #-" ; "Before throwing a"
	line "BAL gooit, verzwak" ; "# BALL, weaken"
	cont "je het doelwit." ; "the target first."

	para "Een vergiftigde of" ; "A poisoned or"
	line "verbrande #MON" ; "burned #MON is"
	cont "vang je sneller." ; "easier to catch."

	para "Blijven lezen?" ; "Keep reading?"
	done

AcademyNotebookText2:
	text "Sommige aanvallen" ; "Some moves may"
	line "kunnen verwarren." ; "cause confusion."

	para "Verwarring laat de" ; "Confusion may make"
	line "#MON soms zich-" ; "a #MON attack"
	cont "zelf aanvallen." ; "itself."

	para "Na een gevecht" ; "Leaving battle"
	line "verdwijnt de" ; "clears up any"
	cont "verwarring." ; "confusion."

	para "Blijven lezen?" ; "Keep reading?"
	done

AcademyNotebookText3:
	text "Mensen die #MON" ; "People who catch"
	line "vangen en ermee" ; "and use #MON"

	para "vechten zijn" ; "in battle are"
	line "#MON-trainers." ; "#MON trainers."

	para "Verwacht wordt dat" ; "They are expected"
	line "ze #MON-gyms" ; "to visit #MON"

	para "bezoeken en andere" ; "GYMS and defeat"
	line "trainers verslaan." ; "other trainers."

	para "De volgende pagina" ; "The next page"
	line "is… Leeg!" ; "is… Blank!"

	para "Jongen: E-he-he…" ; "Boy: E-he-he…"

	para "Meer heb ik niet" ; "I haven't written"
	line "geschreven…" ; "anymore…"
	done

AcademyStickerMachineText:
	text "Deze geweldige" ; "This super machine"
	line "machine print data" ; "prints data out as"
	cont "uit als stickers!" ; "stickers!"
	done

EarlsPokemonAcademy_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 15, VIOLET_CITY, 3
	warp_event  4, 15, VIOLET_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  1,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster1Script, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster2Script, -1
	object_event  2,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
