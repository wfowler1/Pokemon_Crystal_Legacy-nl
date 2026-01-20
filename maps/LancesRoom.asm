	object_const_def
	const LANCESROOM_LANCE
	const LANCESROOM_MARY
	const LANCESROOM_OAK

LancesRoom_MapScripts:
	def_scene_scripts
	scene_script .LockDoor ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_LANCESROOM_APPROACH_LANCE

	def_callbacks
	callback MAPCALLBACK_TILES, .LancesRoomDoors

.LockDoor:
	sdefer .LancesDoorLocksBehindYou
	end

.DummyScene:
	end

.LancesRoomDoors:
	checkevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	iffalse .KeepEntranceOpen
	changeblock 4, 22, $34 ; wall
.KeepEntranceOpen:
	checkevent EVENT_LANCES_ROOM_EXIT_OPEN
	iffalse .KeepExitClosed
	changeblock 4, 0, $0b ; open door
.KeepExitClosed:
	endcallback

.LancesDoorLocksBehindYou:
	applymovement PLAYER, LancesRoom_EnterMovement
	refreshscreen $86
	playsound SFX_STRENGTH
	earthquake 80
	changeblock 4, 22, $34 ; wall
	reloadmappart
	closetext
	setscene SCENE_LANCESROOM_APPROACH_LANCE
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	end

Script_ApproachLanceFromLeft:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromLeft
	sjump LancesRoomLanceScript

Script_ApproachLanceFromRight:
	special FadeOutMusic
	applymovement PLAYER, MovementData_ApproachLanceFromRight
LancesRoomLanceScript:
	turnobject LANCESROOM_LANCE, LEFT
	opentext
	
	readvar VAR_BADGES
	if_less_than 16, .OriginalText1
	writetext LanceRematchBattleIntroText
	sjump .EndText1
.OriginalText1
	writetext LanceBattleIntroText
.EndText1

	waitbutton
	closetext
	winlosstext LanceBattleWinText, 0
	setlasttalked LANCESROOM_LANCE
	readvar VAR_BADGES
	if_greater_than 15, .Rematch
	loadtrainer CHAMPION, LANCE
	sjump .LoadtrainerEnd
.Rematch:
	loadtrainer CHAMPION, 2
.LoadtrainerEnd:
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	readvar VAR_BADGES
	if_less_than 16, .NoRed
	setevent EVENT_ELITE_4_REMATCH
.NoRed
	
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	readvar VAR_BADGES
	if_less_than 9, .BaseCap
	if_not_equal 16, .DontUpdateBadge
	checkevent EVENT_CERULEAN_CAVE_B1F_MEWTWO
	iftrue .DontUpdateBadge
	loadmem wLevelCap, 77 ; update level cap for hard mode
	sjump .DontUpdateBadge
.BaseCap
	loadmem wLevelCap, 60 ; update level cap for hard mode
.DontUpdateBadge

	opentext
	writetext LanceBattleAfterText
	waitbutton
	closetext

; 	checkevent EVENT_BEAT_LANCE_FIRST_TIME
; 	iftrue .ZapdosAlreadyReleased
; 	setval ZAPDOS
;     special ShowPokedexEntry
; .ZapdosAlreadyReleased

	setevent EVENT_BEAT_LANCE_FIRST_TIME
	setevent EVENT_BEAT_CHAMPION_LANCE
	playsound SFX_ENTER_DOOR
	changeblock 4, 0, $0b ; open door
	reloadmappart
	closetext
	setevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	musicfadeout MUSIC_BEAUTY_ENCOUNTER, 16
	pause 30
	showemote EMOTE_SHOCK, LANCESROOM_LANCE, 15
	turnobject LANCESROOM_LANCE, DOWN
	pause 10
	turnobject PLAYER, DOWN
	appear LANCESROOM_MARY
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRushesIn
	opentext
	writetext LancesRoomMaryOhNoOakText
	waitbutton
	closetext
	appear LANCESROOM_OAK
	applymovement LANCESROOM_OAK, LancesRoomMovementData_OakWalksIn
	follow LANCESROOM_MARY, LANCESROOM_OAK
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryYieldsToOak
	stopfollow
	turnobject LANCESROOM_OAK, UP
	turnobject LANCESROOM_LANCE, LEFT
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText2
	writetext LancesRoomRematchOakCongratulationsText
	sjump .EndText2
.OriginalText2
	writetext LancesRoomOakCongratulationsText
.EndText2

	waitbutton
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryInterviewChampion
	turnobject PLAYER, LEFT
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText3
	writetext LancesRoomRematchMaryInterviewText
	sjump .EndText3
.OriginalText3
	writetext LancesRoomMaryInterviewText
.EndText3

	waitbutton
	closetext
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway
	turnobject PLAYER, UP
	opentext
	writetext LancesRoomNoisyText
	waitbutton
	closetext
	follow LANCESROOM_LANCE, PLAYER
	turnobject LANCESROOM_MARY, UP
	turnobject LANCESROOM_OAK, UP
	applymovement LANCESROOM_LANCE, LancesRoomMovementData_LanceLeadsPlayerToHallOfFame
	stopfollow
	playsound SFX_EXIT_BUILDING
	disappear LANCESROOM_LANCE
	applymovement PLAYER, LancesRoomMovementData_PlayerExits
	playsound SFX_EXIT_BUILDING
	disappear PLAYER
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryTriesToFollow
	showemote EMOTE_SHOCK, LANCESROOM_MARY, 15
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText4
	writetext LancesRoomRematchMaryNoInterviewText
	sjump .EndText4
.OriginalText4
	writetext LancesRoomMaryNoInterviewText
.EndText4
	
	pause 30
	closetext
	applymovement LANCESROOM_MARY, LancesRoomMovementData_MaryRunsBackAndForth
	special FadeOutPalettes
	pause 15
	warpfacing UP, HALL_OF_FAME, 4, 13
	end

LancesRoom_EnterMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

MovementData_ApproachLanceFromLeft:
	step UP
	step UP
	turn_head RIGHT
	step_end

MovementData_ApproachLanceFromRight:
	step UP
	step LEFT
	step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryRushesIn:
	big_step UP
	big_step UP
	big_step UP
	turn_head DOWN
	step_end

LancesRoomMovementData_OakWalksIn:
	step UP
	step UP
	step_end

LancesRoomMovementData_MaryYieldsToOak:
	step LEFT
	turn_head RIGHT
	step_end

LancesRoomMovementData_MaryInterviewChampion:
	big_step UP
	turn_head RIGHT
	step_end

LancesRoomMovementData_LancePositionsSelfToGuidePlayerAway:
	step UP
	step LEFT
	turn_head DOWN
	step_end

LancesRoomMovementData_LanceLeadsPlayerToHallOfFame:
	step UP
	step_end

LancesRoomMovementData_PlayerExits:
	step UP
	step_end

LancesRoomMovementData_MaryTriesToFollow:
	step UP
	step RIGHT
	turn_head UP
	step_end

LancesRoomMovementData_MaryRunsBackAndForth:
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step LEFT
	big_step LEFT
	turn_head UP
	step_end

LanceRematchBattleIntroText:
	text "LANCE:" ; "LANCE:"
	line "Welkom terug!" ; "Welcome back!"

    para "Je hebt jezelf" ; "You've proven"
    line "bewezen in JOHTO," ; "yourself in JOHTO,"
	
	para "alle 8 BADGES be-" ; "acquiring all 8"
    line "komen en me zelfs" ; "badges and even"
    cont "eens verslaan." ; "besting me once."

    para "Maar nu, speel je" ; "But now, you're"
    line "in een hogere" ; "in the big"
	cont "klasse." ; "leagues."

	para "De KANTO LEAGUE!" ; "The KANTO LEAGUE!"
	
	para "Een regio met eigen" ; "A region with its"
    line "uitdagingen en" ; "own trials and"
    cont "kampioenen." ; "champions."
	
	para "Hier ben ik de" ; "Here, I am the"
    line "laatste uitdaging," ; "final challenge,"

    para "met een team" ; "with a team "
    line "sterker dan ooit" ; "stronger than ever"
	cont "tevoren." ; "before."

    para "Dit is de ware" ; "This is the true"
    line "test," ; "test,"
	
	para "een gevecht om de" ; "a battle to"
    line "KANTO KAMPIOEN" ; "determine the"
    cont "te bepalen." ; "CHAMPION of KANTO."

    para "Ben je klaar om" ; "Are you ready to"
    line "deze nieuwe uitda-" ; "rise to this new"
    cont "ging aan te gaan?" ; "challenge?" 
	
	para "Om jezelf nogmaals" ; "To prove yourself"
    line "te bewijzen?" ; "once more?"

    para "Toon me de kracht" ; "Show me the"
    line "die JOHTO";  "strength that"
	cont "veroverde," ; "conquered JOHTO,"
    cont "KAMPIOEN." ; "CHAMPION."
    done

LanceBattleIntroText:
	text "LANCE: Ik heb" ; "LANCE: I've been"
	line "op je gewacht." ; "waiting for you."

	para "<PLAY_G>!" ; "<PLAY_G>!"

	para "Ik wist dat met" ; "I knew that you,"
	line "jouw vaardigheden" ; "with your skills,"

	para "je me uiteindelijk" ; "would eventually"
	line "hier zou bereiken." ; "reach me here."
	
	para "Drie jaar geleden" ; "Three years ago"
	line "stond een trainer" ; "a trainer"
	
	para "net als jij voor" ; "just like you"
	line "me." ; "stood before me."
	
	para "Die trainer zou" ; "That trainer would"
	line "later de sterkste" ; "go on to become"
	
	para "in ons beider" ; "the strongest in"
	line "regio's worden." ; "both our regions."
	
	para "Hij droeg me op" ; "He has entrusted"
	line "om de LEAGUE te" ; "me to uphold the"
	cont "verdedidgen en te" ; "LEAGUE, and to"
	
	para "zorgen voor de" ; "take care of"
	line "legendarische" ; "the legendary"
	
	para "bliksemvogel," ; "lightning bird,"
	line "ZAPDOS." ; "ZAPDOS."

	para "Er zijn nu geen" ; "There's no need"
	line "woorden meer nodig." ; "for any more"
;	cont "words now."

	para "We zullen vechten" ; "We will battle to"
	line "om te beslissen" ; "determine who is"

	para "wie van ons twee" ; "the stronger of"
	line "de sterkste is." ; "the two of us."

	para "als de #MON" ; "As the #MON"
	line "LEAGUE KAMPIOEN…" ; LEAGUE CHAMPION…"

	para "accepter ik, LANCE" ; "I, LANCE the drag-"
	line "de drakenmeester," ; "on master, accept"
	cont "je uitdaging." ; "your challenge!"

	done

LanceBattleWinText:
	text "…Het is voorbij." ; "…It's over."

	para "Maar het is een" ; "But it's an odd"
	line "vreemd gevoel." ; "feeling."

	para "Ik ben niet boos" ; "I'm not angry that"
	line "dat ik heb ver-" ; "I lost. In fact, I"
	cont "loren. Sterker" ; "feel happy."
	cont "nog, ik ben blij." ;

	para "Blij dat ik ge-" ; "Happy that I"
	line "tuige ben van de" ; "witnessed the rise"

	para "opkomst van een" ; "of a great new"
	line "geweldige nieuwe" ; "CHAMPION!"
	cont "KAMPIOEN!" ;
	done

LanceBattleAfterText:
	text "…Pfoe." ; "…Whew."

	para "Je bent echt" ; "You have become"
	line "sterk geworden," ; "truly powerful,"
	cont "<PLAY_G>."

	para "Je #MON hebben" ; "Your #MON have"
	line "je sterke en" ; "responded to your"

	para "oprechte aard" ; "strong and up-"
	line "aangevoeld." ; "standing nature."

	para "Als een trainer" ; "As a trainer, you"
	line "zul je blijven" ; "will continue to"

	para "groeien met je" ; "grow strong with"
	line "#MON." ; "your #MON."
	done

LancesRoomMaryOhNoOakText:
	text "MARY: Oh nee!" ; "MARY: Oh, no!"
	line "Het is al voorbij!" ; "It's all over!"

	para "PROF.OAK, als je" ; "PROF.OAK, if you"
	line "nou niet zo" ; "weren't so slow…"
	cont "langzaam was…" ;
	done

LancesRoomOakCongratulationsText:
	text "PROF.OAK: Ah," ; "PROF.OAK: Ah,"
	line "<PLAY_G>!" ; "<PLAY_G>!"

	para "Het is alweer een" ; "It's been a long"
	line "hele tijd geleden." ; "while."

	para "Je ziet er zeker" ; "You certainly look"
	line "indrukwekkender" ; "more impressive."
	cont "uit." ;

	para "Je overwinning op" ; "Your conquest of"
	line "de JOHTO LEAGUE is" ; "the JOHTO LEAGUE"
	cont "gewoon brilliant!" ; "is just fantastic!"

	para "Je toewijding," ; "Your dedication,"
	line "vertrouwen en" ; "trust and love for"

	para "liefde voor je" ; "your #MON made"
	line "#MON zorgden" ; "this happen."
	cont "hiervoor." ;

	para "Je #MON waren" ; "Your #MON were"
	line "ook waanzinnig." ; "outstanding too."

	para "Omdat ze in jou" ; "Because they be-"
	line "als een trainer" ; "lieved in you as a"

	para "geloven, lukte het" ; "trainer, they per-"
	line "te winnen." ; "severed."

	para "Gefeliciteerd," ; "Congratulations,"
	line "<PLAY_G>!"
	done

LancesRoomRematchOakCongratulationsText:
	text "PROF.OAK: Ah," ; "PROF.OAK: Ah,"
    line "<PLAY_G>!" ; "<PLAY_G>!"

	para "Ik volg je voor-" ; "I've been following"
    line "uitgang al sinds" ; "your progress"
    cont "PROF. ELM je mijn" ; "since PROF."
    cont "kant opstuurde." ; "ELM sent you on"
;	cont "your way."

    para "Je bent voorwaar" ; "You've certainly"
    line "indrukwekkender" ; "become more"
	cont "geworden." ; "impressive."

    para "Zowel de JOHTO als" ; "Conquering both"
    line "KANTO LEAGUE over-" ; "the JOHTO and now"
    cont "winnen is geen" ; "the KANTO LEAGUE"
    cont "geringe prestatie." ; "is no small feat."
	
	para "Je hebt jezelf" ; "You've truly"
    line "echt overtroffen!" ; "outdone yourself!"

    para "Het is duidelijk" ; "It's clear that"
    line "dat je #MON je" ; "your #MON trust"
    cont "immens vertrouwen," ; "you immensely,"
	
	para "en dat deze band" ; "and that trust has"
    line "het fundament was" ; "been the"
    cont "voor je succes." ; "foundation of your"
;	cont "success."

    para "Maar onthoud, de" ; "But remember, a"
    line "reis van een" ; "trainer's journey"
    cont "trainer is nooit" ; "is never truly"
	cont "echt voorbij." ; "over."

    para "Bezoek me in mijn" ; "When you have a"
    line "lab, wanneer je" ; "moment, do visit"
    cont "een momentje hebt." ; "me in my lab."
	
	para "Er is iets wat" ; "There's something"
    line "ik graag met je" ; "I'd like to"
    cont "wil bespreken." ; "discuss with you."

    para "Gefeliciteerd met" ; "Congratulations on"
    line "je overwinning," ; "your victory,"
	cont "<PLAY_G>!"  ; "<PLAY_G>!"
	done

LancesRoomMaryInterviewText:
	text "MARY: Laten we de" ; "MARY: Let's inter-"
	line "de gloednieuwe" ; "view the brand new"
	cont "JOHTO KAMPIOEN" ; "JOHTO CHAMPION!"
	cont "interviewen!" ; 
	done

LancesRoomRematchMaryInterviewText:
	text "MARY: Laten we de" ; "MARY: Let's inter-"
	line "de gloednieuwe" ; "view the brand new"
	cont "KANTO KAMPIOEN" ; "KANTO CHAMPION!"
	cont "interviewen!" ; 
	done

LancesRoomNoisyText:
	text "LANCE: Het wordt" ; "LANCE: This is"
	line "een beetje druk" ; "getting to be a"
	cont "hier…" ; "bit too noisy…"

	para "<PLAY_G>, kan je" ; "<PLAY_G>, could you"
	line "met me mee komen?" ; "come with me?"
	done

LancesRoomMaryNoInterviewText:
	text "MARY: Oh, wacht!" ; "MARY: Oh, wait!"
	line "We hebben nog" ; "We haven't done"
	cont "geen interview!" ; "the interview!"
	done

LancesRoomRematchMaryNoInterviewText:
	text "MARY: Kom nou zeg!" ; "MARY: Come on!"
	line "Het interview af-" ; "You can't blow off"
	cont "zeggen? NOGMAALS!" ; "the interview"
;	cont "AGAIN!"
	done

LancesRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 23, KARENS_ROOM, 3
	warp_event  5, 23, KARENS_ROOM, 4
	warp_event  4,  1, HALL_OF_FAME, 1
	warp_event  5,  1, HALL_OF_FAME, 2

	def_coord_events
	coord_event  4,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromLeft
	coord_event  5,  5, SCENE_LANCESROOM_APPROACH_LANCE, Script_ApproachLanceFromRight

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LancesRoomLanceScript, -1
	object_event  4,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
	object_event  4,  7, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_LANCES_ROOM_OAK_AND_MARY
