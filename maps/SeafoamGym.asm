	object_const_def
	const SEAFOAMGYM_BLAINE
	const SEAFOAMGYM_GYM_GUIDE

SeafoamGym_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks

.DummyScene:
	end

SeafoamGymBlaineScript:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftrue .FightDone
	writetext BlaineIntroText
	waitbutton
	closetext
	winlosstext BlaineWinLossText, 0
	loadtrainer BLAINE, BLAINE1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_BLAINE1
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_BLAINE1
	startbattle
	iftrue .ReturnAfterBattle
	appear SEAFOAMGYM_GYM_GUIDE
.ReturnAfterBattle:
	reloadmapafterbattle
	clearevent EVENT_CAUGHT_MOLTRES
	opentext
	writetext ReceivedVolcanoBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_VOLCANOBADGE

; 	checkevent EVENT_BEAT_BLAINE
; 	iftrue .MoltresAlreadyReleased
; 	setval MOLTRES
;     special ShowPokedexEntry
; .MoltresAlreadyReleased

	setevent EVENT_BEAT_BLAINE
	writetext BlaineAfterBattleText
	waitbutton
	closetext
	jumpstd KantoLevelCapUpdateScript
	end

.FightDone:
	checkevent EVENT_ELITE_4_REMATCH
	iffalse .NotBeatE4Rematch
	writetext BlaineRematchText
	yesorno
	iftrue .BlaineRematch
	sjump .SaidNo
.NotBeatE4Rematch
	writetext BlaineFightDoneText
	waitbutton
.SaidNo
	closetext
	end

.BlaineRematch:
	special HealParty
	winlosstext Blaine_RematchDefeatText, 0
	loadtrainer BLAINE, BLAINE1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
	.normalmode_2
	startbattle
	reloadmapafterbattle
	end

SeafoamGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	iftrue .TalkedToSeafoamGymGuideScript
	writetext SeafoamGymGuideWinText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	end

.TalkedToSeafoamGymGuideScript:
	writetext SeafoamGymGuideWinText2
	waitbutton
	closetext
	end

BlaineIntroText:
	text "BLAINE: Waaah!"

	para "My GYM in CINNABAR"
	line "burned down."
	
	para "But I'm back in"
	line "business as a GYM"

	para "LEADER here in"
	line "this cave."

	para "It's fine though,"
	line "I have faced"

	para "hardship like"
	line "this before."

	para "Long ago I was"
	line "lost in the"
	
	para "mountains until"
	line "a fiery bird"
	
	para "#MON appeared"
	line "to lead me down."
	
	para "All these years"
	line "later and now"
	
	para "RED has entrusted"
	line "me to look over"

	para "that same"
	line "legendary bird,"

	para "MOLTRES."
	
	para "Ha! You'd better"
	line "have BURN HEAL,"
	
	para "It's even hotter"
	line "than your mom!"
	done

BlaineWinLossText:
	text "BLAINE: Geweldig." ; "BLAINE: Awesome."
	line "Ik ben opgebrand…" ; "I've burned out…"

	para "Deze VULKAANBADGE" ; "You've earned"
	line "heb je verdiend!" ; "VOLCANOBADGE!"
	done

ReceivedVolcanoBadgeText:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "VULKAANBADGE." ; "VOLCANOBADGE."
	done

BlaineAfterBattleText:
	text "BLAINE: Deze keer" ; "BLAINE: I did lose"
	line "verloor ik, maar" ; "this time, but I'm"

	para "de volgende keer" ; "going to win the"
	line "win ik." ; "next time."

	para "Laten we nogmaals" ; "When I rebuild my"
	line "strijden als ik" ; "CINNABAR GYM,"

	para "CINNABAR GYM heb" ; "we'll have to have"
	line "herbouwd." ; "a rematch."
	done

BlaineFightDoneText:
	text "BLAINE: Mijn vuur-" ; "BLAINE: My fire"
	line "#MON zullen nog" ; "#MON will be"

	para "sterker zijn." ; "even stronger."
	line "Kijk maar uit!" ; "Just you watch!"
	done

BlaineRematchText:
	text "BLAINE: Whoa!"

	para "I see you've"
	line "become the"
	cont "KANTO CHAMPION!"

	para "That's blazing!"

	para "Your skills are"
	line "top-notch."

	para "I'm always"
	line "up for a battle."

	para "Want to have a"
	line "rematch with me?"
	done

Blaine_RematchDefeatText:
	text "BLAINE: Your"
	line "skills are truly"
	cont "fiery!"

	para "You've burned"
	line "right through"
	cont "my defenses."
	done

SeafoamGymGuideWinText:
	text "Yo!" ; "Yo!"

	para "… Huh? Is het" ; "… Huh? It's over"
	line "al voorbij?" ; "already?"

	para "Sorry, sorry!" ; "Sorry, sorry!"

	para "CINNABAR GYM be-" ; "CINNABAR GYM was"
	line "staat niet meer," ; "gone, so I didn't"

	para "dus ik wist niet" ; "know where to find"
	line "waar je was." ; "you."

	para "Maar, hé, ik wist" ; "But, hey, you're"
	line "dat je zou winnen." ; "plenty strong even"

	para "Je hebt m'n advies" ; "without my advice."
	line "niet meer nodig!" ; "I knew you'd win!"
	done

SeafoamGymGuideWinText2:
	text "Een #MON-GYM" ; "A #MON GYM can"
	line "kan overal zijn" ; "be anywhere as"

	para "zolang er een" ; "long as the GYM"
	line "GYMLEIDER is." ; "LEADER is there."

	para "Een gebouw is niet" ; "There's no need"
	line "per se nodig." ; "for a building."
	done

SeafoamGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, ROUTE_20, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_BLAINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SeafoamGymBlaineScript, -1
	object_event  6,  5, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SeafoamGymGuideScript, EVENT_SEAFOAM_GYM_GYM_GUIDE
