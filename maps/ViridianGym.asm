	object_const_def
	const VIRIDIANGYM_BLUE
	const VIRIDIANGYM_GYM_GUIDE

ViridianGym_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianGymBlueScript:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, BLUE1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_BLUE1
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_BLUE1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_CAUGHT_ARTICUNO
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
	jumpstd KantoLevelCapUpdateScript

; 	checkevent EVENT_BEAT_BLUE
; 	iftrue .ArticunoAlreadyReleased
; 	setval ARTICUNO
;     special ShowPokedexEntry
; .ArticunoAlreadyReleased

	setevent EVENT_BEAT_BLUE
	writetext LeaderBlueAfterText
	waitbutton
	closetext
	end

.FightDone:
	checkevent EVENT_ELITE_4_REMATCH
	iffalse .NotBeatE4Rematch
	writetext BlueRematchText
	yesorno
	iftrue .BlueRematch
	sjump .SaidNo
.NotBeatE4Rematch
	writetext LeaderBlueEpilogueText
	waitbutton
.SaidNo
	closetext
	end

.BlueRematch:
	special HealParty
	winlosstext Blue_RematchDefeatText, 0
	loadtrainer BLUE, BLUE1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
	.normalmode_2
	startbattle
	reloadmapafterbattle
	end

ViridianGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BLUE
	iftrue .ViridianGymGuideWinScript
	writetext ViridianGymGuideText
	waitbutton
	closetext
	end

.ViridianGymGuideWinScript:
	writetext ViridianGymGuideWinText
	waitbutton
	closetext
	end

ViridianGymStatue:
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script

.Beaten:
	gettrainername STRING_BUFFER_4, BLUE, BLUE1
	jumpstd GymStatue2Script

LeaderBlueBeforeText:
	text "BLUE: Yo! Je bent" ; "BLUE: Yo! Finally"
	line "eindelijk hier he?" ; "got here, huh?"

	para "Ik had er geen zin" ; "I wasn't in the"
	line "in op CINNABAR," ; "mood at CINNABAR,"

	para "maar nu ben ik" ; "but now I'm ready"
	line "klaar om met je" ; "to battle you."
	cont "te vechten." ;

	para "…"

	para "Je zegt dat je" ; "You're telling me"
	line "alle GYMS in" ; "you conquered all"
	cont "JOHTO hebt" ; "the GYMS in JOHTO?"
	cont "verslagen?" ;

	para "Heh! De GYMS van" ; "Heh! JOHTO's GYMS"
	line "JOHTO moeten best" ; "must be pretty"
	cont "treurig zijn dan." ; "pathetic then."

	para "Hé, maak je" ; "Hey, don't worry"
	line "geen zorgen." ; "about it."

	para "Door nu met je" ; "I'll know if you"
	line "te vechten zal" ; "are good or not by"

	para "ik weten of je" ; "battling you right"
	line "goed bent." ; "now."

	para "Klaar, JOHTO-" ; "Ready, JOHTO"
	line "KAMPIOEN?" ; "CHAMP?"
	done

LeaderBlueWinText:
	text "BLUE: Wat?" ; "BLUE: What?"

	para "Hoe heb ik nou" ; "How the heck did I"
	line "van je verloren?" ; "lose to you?"

	para "…"

	para "Tss, vooruit…" ; "Tch, all right…"
	line "Hier, neem dit--" ; "Here, take this--"
	cont "de AARDEBADGE." ; "it's EARTHBADGE."
	done

Text_ReceivedEarthBadge:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "AARDEBADGE." ; "EARTHBADGE."
	done

LeaderBlueAfterText:
	text "BLUE: …"

	para "Oké, ik had 't" ; "All right, I was"
	line "mis. Je bent 't" ; "wrong. You're the"

	para "echte werk. Je" ; "real deal. You are"
	line "bent een goede" ; "a good trainer."

	para "trainer. Maar ik" ; "But I'm going to"
	line "ga je ooit" ; "beat you someday."
	cont "verslaan." ;

	para "Vergeet dat" ; "Don't you forget"
	line "niet!" ; "it!"
	done

LeaderBlueEpilogueText:
	text "BLUE: Luister." ; "BLUE: Listen, you."

	para "Zorg dat je niet" ; "You'd better not"
	line "verliest totdat" ; "lose until I beat"
	cont "ik je versla." ; "you. Got it?"
	cont "Begrepen?" ;
	done

BlueRematchText:
	text "BLUE: Wel, wel," ; "BLUE: Well, well."
	line "KANTO KAMPIOEN!" ; "KANTO CHAMPION!"

	para "Je lijkt sterk" ; "Looks like you've"
	line "gevorderd te zijn." ; "come a long way."

	para "Ik had die titel" ; "I used to have"
	line "ooit ook, weet je." ; "that title too,"
	cont "Maar ik maak het" ; "you know. But I"
	cont "je niet makkelijk." ; "won't go easy."

	para "Eens zien of je" ; "Let's see if you"
	line "het kan volhouden." ; "can keep it up."

	para "Wil je een rematch" ; "Want to have a"
	line "met me?" ; "rematch with me?"
	done

Blue_RematchDefeatText:
	text "BLUE: Wat?" ; "BLUE: What?"

	para "Hoe de flip ver-" ; "How the heck did I"
	line "loor ik nogmaals?" ; "lose again?"
	done

ViridianGymGuideText:
	text "Yo, KAMPIOEN" ; "Yo, CHAMP in"
	line "in het verschiet!" ; "making!"

	para "Hoe gaat ie?" ; "How's it going?"
	line "Zo te zien ben je" ; "Looks like you're"
	cont "goed op dreef." ; "on a roll."

	para "De GYMLEIDER is" ; "The GYM LEADER is"
	line "een gast die met" ; "a guy who battled"

	para "de KAMPIOEN heeft" ; "the CHAMPION three"
	line "gevochten drie" ; "years ago."
	cont "jaar geleden." ;

	para "Hij is geen watje." ; "He's no pushover."

	para "Geef het alles" ; "Give it everything"
	line "wat je in je hebt!" ; "you've got!"
	done

ViridianGymGuideWinText:
	text "Jee, je bent echt" ; "Man, you are truly"
	line "sterk…" ; "tough…"

	para "Dat was een heel" ; "That was a heck of"
	line "inspirerend ge-" ; "an inspirational"

	para "vecht. Ik had tra-" ; "battle. It brought"
	line "nen in mijn ogen." ; "tears to my eyes."
	done

ViridianGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VIRIDIAN_CITY, 1
	warp_event  5, 17, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, ViridianGymStatue
	bg_event  6, 13, BGEVENT_READ, ViridianGymStatue

	def_object_events
	object_event  5,  3, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianGymBlueScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianGymGuideScript, EVENT_VIRIDIAN_GYM_BLUE
