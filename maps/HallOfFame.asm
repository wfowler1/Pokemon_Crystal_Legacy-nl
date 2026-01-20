	object_const_def
	const HALLOFFAME_LANCE

HallOfFame_MapScripts:
	def_scene_scripts
	scene_script .EnterHallOfFame ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks

.EnterHallOfFame:
	sdefer .EnterHallOfFameScript
	end

.DummyScene:
	end

.EnterHallOfFameScript:
	follow HALLOFFAME_LANCE, PLAYER
	applymovement HALLOFFAME_LANCE, HallOfFame_WalkUpWithLance
	stopfollow
	turnobject PLAYER, RIGHT
	opentext

	readvar VAR_BADGES
	if_less_than 16, .OriginalText
	writetext HallOfFame_Rematch_LanceText
	sjump .EndText
.OriginalText
	writetext HallOfFame_LanceText
.EndText

	waitbutton
	closetext
	turnobject HALLOFFAME_LANCE, UP
	applymovement PLAYER, HallOfFame_SlowlyApproachMachine
	setscene SCENE_FINISHED
	pause 15
	setval HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_TELEPORT_GUY
	setevent EVENT_RIVAL_SPROUT_TOWER
	clearevent EVENT_RED_IN_MT_SILVER
	setevent EVENT_OLIVINE_PORT_SPRITES_BEFORE_HALL_OF_FAME
	clearevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	setmapscene SPROUT_TOWER_3F, SCENE_FINISHED
	special HealParty
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue .SkipPhoneCall
	specialphonecall SPECIALCALL_SSTICKET
.SkipPhoneCall:
	halloffame
	end

HallOfFame_WalkUpWithLance:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

HallOfFame_SlowlyApproachMachine:
	slow_step UP
	step_end

HallOfFame_LanceText:
	text "LANCE: Het is lang" ; "LANCE: It's been a"
	line "geleden sinds ik" ; "long time since I"
	cont "laatst hier kwam." ; "last came here."

	para "Hier eren wij de" ; "This is where we"
	line "KAMPIOENEN van de" ; "honor the LEAGUE"

	para "LEAGUE tot in de" ; "CHAMPIONS for all"
	line "eeuwigheid." ; "eternity."

	para "Hun heldhaftige" ; "Their courageous"
	line "#MON worden ook" ; "#MON are also"
	cont "ingeleid." ; "inducted."

	para "We zijn vandaag" ; "Here today, we"
	line "getuige van de" ; "witnessed the rise"

	para "opkomst van een" ; "of a new LEAGUE"
	line "nieuwe KAMPIOEN--" ; "CHAMPION--a"

	para "een trainer die" ; "trainer who feels"
	line "compassie voor en" ; "compassion for,"

	para "vertrouwen in alle" ; "and trust toward,"
	line "#MON heeft." ; "all #MON."

	para "Een trainer die" ; "A trainer who"
	line "slaagde dankzij" ; "succeeded through"

	para "volharding en" ; "perseverance and"
	line "vastberadenheid." ; "determination."

	para "De nieuwe LEAGUE-" ; "The new LEAGUE"
	line "KAMPIOEN die alles" ; "CHAMPION who has"

	para "heeft om groots" ; "all the makings"
	line "te zijn!" ; "of greatness!"

	para "<PLAY_G>, laat mij" ; "<PLAY_G>, allow me"
	line "jou en je partners" ; "to register you"

	para "registreren als" ; "and your partners"
	line "KAMPIOENEN!" ; "as CHAMPIONS!"
	done

HallOfFame_Rematch_LanceText:
	text "LANCE: ik herinner" ; "LANCE: I remember,"
    line "niet zo lang gele-" ; "it wasn't long ago"
    cont "den hier te staan," ; "I stood here,"

    para "om je te verwelko-" ; "welcoming you as"
    line "men als de JOHTO" ; the CHAMPION of"
    cont "KAMPIOEN." ; "JOHTO."

    para "En nu staan we" ; "And now, here we"
    line "hier weer, in deze" ; "are again,"
	
	para "heilige plek waar" ; "in this sacred"
    line "we de uiterst" ; "place where we"
    cont "beste trainers en" ; "honor the very "
    cont "hun #MON eren." ; "best trainers"
;	cont "and their #MON." ; 

    para "Vandaag heb je je" ; "Today, you've"
    line "niet enkel bewezen" ; "proven yourself"
	cont "in JOHTO maar ook" ; "not just in JOHTO,"
	
	para "in KANTO door ook" ; "but in KANTO as"
    line "mijn sterkste team" ; "well,"
	
	para "te verslaan." ; "besting even my"
;    line "strongest team." ; 

    para "Je toonde opmerke-" ; "You've shown"
    line "lijk medeleven en" ; "remarkable"
	cont "vertrouwen in je" ; "compassion and"
    cont "#MON," ; "trust in your"
;    cont "#MON,"
	
	para "een band die je" ; "a bond that"
    line "telkens liet" ; "has carried you to"
    cont "triomferen." ; "victory time and"
;    cont "again."

    para "Je reis, getekend" ; "Your journey,"
    line "door volharding en" ; "marked by"
	cont "onwrikbare vast-" ; "perseverance and"
    cont "beradenheid," ; unwavering"
;	cont "determination,"

    para "weerspiegelt je" ; "speaks to your"
    line "ware aard als" ; "true spirit as a"
	cont "trainer."

    para "Je hebt alles om" ; "You have all the"
    line "een grootse" ; "makings of a true"
    cont "trainer te worden," ; "great,"
	
	para "misschien zelfs de" ; "perhaps even"
    line "grootste ooit." ; "the greatest."

    para "<PLAY_G>," ; "<PLAY_G>,"
	line "het is een eer om" ; "it is my honor"
    cont "jou en je trouwe" ; "to register you,"

    para "partners nogmaals" ; "and your trusted"
    line "als kampioenen te" ; "partners,"

	para "registreren." ; "as champions"
;    line "once again."
    done

HallOfFame_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 13, LANCES_ROOM, 3
	warp_event  5, 13, LANCES_ROOM, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4, 12, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
