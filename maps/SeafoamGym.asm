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
	text "BLAINE: Waaah!" ; "BLAINE: Waaah!"

	para "Mijn GYM in CINNA-" ; "My GYM in CINNABAR"
	line "BAR is afgebrand." ; "burned down."
	
	para "Maar ik ga weer" ; "But I'm back in"
	line "aan de slag als" ; "business as a GYM"

	para "GYMLEIDER hier in" ; "LEADER here in"
	line "deze grot." ; "this cave."

	para "Het is ok, hoor." ; "It's fine though,"
	line "Ik heb al ergere" ; "I have faced"

	para "ontberingen" ; "hardship like"
	line "doorstaan." ; "this before."

	para "Lang geleden was" ; "Long ago I was"
	line "ik verdwaald in de" ; "lost in the"
	
	para "bergen toen een" ; "mountains until"
	line "vurige vogel-" ; "a fiery bird"
	
	para "#MON verscheen" ; "#MON appeared"
	line "en de weg wees." ; "to lead me down."
	
	para "Nu, al deze jaren" ; "All these years"
	line "later, heeft RED" ; "later and now"
	
	para "me deze legenda-" ; "RED has entrusted"
	line "rische vogel toe-" ; "me to look over"

	para "vertrouwd:MOLTRES." ; "that same"
;	line "legendary bird,"

;	para "MOLTRES."
	
	para "Ha! Hopelijk heb" ; "Ha! You'd better"
	line "je BRANDZALF mee," ; "have BURN HEAL,"
	
	para "MOLTRES is nog" ; "It's even hotter"
	line "feller dan je ma!" ; "than your mom!"
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
	text "BLAINE: Whoa!" ; "BLAINE: Whoa!"

	para "Ik zie dat je" ; "I see you've"
	line "KANTO KAMPIOEN" ; "become the"
	cont "werd!" ; "KANTO CHAMPION!"

	para "Dat is laaiend!" ; "That's blazing!"

	para "Je vaardigheden" ; "Your skills are"
	line "zijn uitstekend." ; "top-notch."

	para "Ik sta steeds klaar" ; "I'm always"
	line "voor een gevecht." ; "up for a battle."

	para "Wil je een rematch" ; "Want to have a"
	line "met me?" ; "rematch with me?"
	done

Blaine_RematchDefeatText:
	text "BLAINE: Je staat" ; "BLAINE: Your"
	line "werkelijk in vuur" ; "skills are truly"
	cont "en vlam!" ; "fiery!"

	para "Je veraste mijn" ; "You've burned"
	line "verdedigingen" ; "right through"
	cont "volledig." ; "my defenses."
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
