	object_const_def
	const TEAMROCKETBASEB3F_LANCE
	const TEAMROCKETBASEB3F_ROCKET1
	const TEAMROCKETBASEB3F_MOLTRES
	const TEAMROCKETBASEB3F_ROCKET_GIRL
	const TEAMROCKETBASEB3F_ROCKET2
	const TEAMROCKETBASEB3F_SCIENTIST1
	const TEAMROCKETBASEB3F_SCIENTIST2
	const TEAMROCKETBASEB3F_ROCKET3
	const TEAMROCKETBASEB3F_SILVER
	const TEAMROCKETBASEB3F_POKE_BALL1
	const TEAMROCKETBASEB3F_POKE_BALL2
	const TEAMROCKETBASEB3F_POKE_BALL3
	const TEAMROCKETBASEB3F_POKE_BALL4
	const TEAMROCKETBASEB3F_POKE_BALL5

TeamRocketBaseB3F_MapScripts:
	def_scene_scripts
	scene_script .LanceGetsPassword ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	scene_script .DummyScene2 ; SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	scene_script .DummyScene3 ; SCENE_TEAMROCKETBASEB3F_NOTHING

	def_callbacks
	callback MAPCALLBACK_TILES, .CheckGiovanniDoor

.LanceGetsPassword:
	sdefer LanceGetPasswordScript
	end

.DummyScene1:
	end

.DummyScene2:
	end

.DummyScene3:
	end

.CheckGiovanniDoor:
	checkevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	iftrue .OpenSesame
	endcallback

.OpenSesame:
	changeblock 10, 8, $07 ; floor
	endcallback

LanceGetPasswordScript:
	turnobject PLAYER, LEFT
	pause 5
	turnobject TEAMROCKETBASEB3F_MOLTRES, RIGHT
	pause 20
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceApproachesPlayerMovement
	opentext
	writetext LanceGetPasswordText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceLeavesMovement
	disappear TEAMROCKETBASEB3F_LANCE
	setscene SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	end

RocketBaseRival:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	appear TEAMROCKETBASEB3F_SILVER
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalEnterMovement
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext RocketBaseRivalText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, RocketBaseRivalShovesPlayerMovement
	applymovement TEAMROCKETBASEB3F_SILVER, RocketBaseRivalLeavesMovement
	disappear TEAMROCKETBASEB3F_SILVER
	setscene SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	special RestartMapMusic
	end

TeamRocketBaseB3FRocketScript:
	jumptextfaceplayer TeamRocketBaseB3FRocketText

RocketBaseBossLeft:
	applymovement PLAYER, RocketBasePlayerApproachesBossLeftMovement
	sjump RocketBaseBoss

RocketBaseBossRight:
	applymovement PLAYER, RocketBasePlayerApproachesBossRightMovement
RocketBaseBoss:
	pause 30
	showemote EMOTE_SHOCK, TEAMROCKETBASEB3F_ROCKET1, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject TEAMROCKETBASEB3F_ROCKET1, DOWN
	opentext
	writetext ExecutiveM4BeforeText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossApproachesPlayerMovement
	winlosstext ExecutiveM4BeatenText, 0
	setlasttalked TEAMROCKETBASEB3F_ROCKET1
	loadtrainer ROCKET_LEADER, 2
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_4
	opentext
	writetext ExecutiveM4AfterText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossHitsTableMovement
	playsound SFX_TACKLE
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossLeavesMovement
	disappear TEAMROCKETBASEB3F_ROCKET1
	setscene SCENE_TEAMROCKETBASEB3F_NOTHING
	end

RocketBaseMurkrow:
	opentext
	writetext RocketBaseMurkrowText
	waitbutton
	closetext
	setevent EVENT_LEARNED_HAIL_GIOVANNI
	end

SlowpokeTailGrunt:
	trainer GRUNTF, GRUNTF_5, EVENT_BEAT_ROCKET_GRUNTF_5, GruntF5SeenText, GruntF5BeatenText, 0, GruntF5Script

GruntF5Script:
	endifjustbattled
	opentext
	writetext GruntF5AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_SLOWPOKETAIL
	end

RaticateTailGrunt:
	trainer GRUNTM, GRUNTM_28, EVENT_BEAT_ROCKET_GRUNTM_28, GruntM28SeenText, GruntM28BeatenText, 0, GruntM28Script

GruntM28Script:
	endifjustbattled
	opentext
	writetext GruntM28AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_RATICATE_TAIL
	end

TrainerScientistRoss:
	trainer SCIENTIST, ROSS, EVENT_BEAT_SCIENTIST_ROSS, ScientistRossSeenText, ScientistRossBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistRossAfterBattleText
	waitbutton
	closetext
	end

TrainerScientistMitch:
	trainer SCIENTIST, MITCH, EVENT_BEAT_SCIENTIST_MITCH, ScientistMitchSeenText, ScientistMitchBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistMitchAfterBattleText
	waitbutton
	closetext
	end

TeamRocketBaseB3FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_SLOWPOKETAIL
	iffalse .NeedsPassword
	checkevent EVENT_LEARNED_RATICATE_TAIL
	iffalse .NeedsPassword
	sjump .OpenSesame

.NeedsPassword:
	writetext TeamRocketBaseB3FLockedDoorNeedsPasswordText
	waitbutton
	closetext
	end

.OpenSesame:
	writetext TeamRocketBaseB3FLockedDoorOpenSesameText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 10, 8, $07 ; floor
	reloadmappart
	closetext
	setevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	waitsfx
	end

TeamRocketBaseB3FOathScript:
	jumpstd TeamRocketOathScript

TeamRocketBaseB3FProtein:
	itemball PROTEIN

TeamRocketBaseB3FXSpecial:
	itemball X_SPECIAL

TeamRocketBaseB3FFullHeal:
	itemball FULL_HEAL

TeamRocketBaseB3FIceHeal:
	itemball ICE_HEAL

TeamRocketBaseB3FUltraBall:
	itemball ULTRA_BALL

RocketBaseLanceApproachesPlayerMovement:
	step RIGHT
	step_end

RocketBaseLanceLeavesMovement:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerApproachesBossLeftMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBasePlayerApproachesBossRightMovement:
	step UP
	step UP
	step LEFT
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBaseBossApproachesPlayerMovement:
	step DOWN
	step_end

RocketBaseBossHitsTableMovement:
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossLeavesMovement:
	fix_facing
	fast_jump_step LEFT
	remove_fixed_facing
	step_sleep 8
	step_sleep 8
	slow_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseRivalEnterMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseRivalLeavesMovement:
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBaseRivalShovesPlayerMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

LanceGetPasswordText:
	text "LANCE: Er zijn" ; " ; "LANCE: It takes"
	line "twee wachtwoorden" ; "two passwords to"

	para "nodig om in de" ; "get into the"
	line "vertrekken van de" ; "boss's quarters."
	cont "baas te komen." ; 

	para "Die wachtwoorden" ; "Those passwords"
	line "weten alleen" ; "are known only to"
	cont "een paar ROCKETS." ; "a few ROCKETS."

	para "Die ROCKET daar" ; "That ROCKET there"
	line "heeft me dat zeer" ; "very graciously"
	cont "welwillend ver-" ; "told me so."
	cont "teld." ;

	para "<PLAY_G>, laten" ; "<PLAY_G>, let's go"
	line "we die wachtwoord-" ; "get the passwords."
	cont "en vinden." ;
	done

TeamRocketBaseB3FRocketText:
	text "Urrggh… Die gozer" ; "Urrggh… The guy"
	line "in de cape is" ; "in the cape is"
	cont "supersterk…" ; "incredibly tough…"
	done

RocketBaseRivalText:
	text "…" ; "…"

	para "Zei ik je niet" ; "Didn't I tell you"
	line "dat ik TEAM ROCKET" ; "that I was going"

	para "ging vernietigen?" ; "to destroy TEAM"
;	line "ROCKET?"

	para "…Zeg eens, wie was" ; "…Tell me, who was"
	line "die gast in de" ; "the guy in the"

	para "cape die DRAAK-" ; "cape who used"
	line "#MON gebruikt?" ; "dragon #MON?"

	para "Mijn #MON maak-" ; "My #MON were no"
	line "ten geen schijn" ; "match at all."
	cont "van kans." ; 

	para "Maar wat hij zei" ; "It's what he said"
	line "stoort me…" ; "that bothers me…"

	para "Hij zei dat ik" ; "He told me that"
	line "mijn #MON niet" ; "I don't love and"

	para "genoeg vertrouw" ; "trust my #MON"
	line "en liefheb." ; "enough."
	
	para "Het is niet mijn" ; "It's not my fault"
	line "fout dat mijn team" ; "my team is so"
	cont "zo nutteloos is." ; "useless."

	para "Ik ben woedend dat" ; "I'm furious that I"
	line "ik verloor van zo" ; lost to a bleeding"
	cont "een zacht ei." ; "heart like him."
	
	para "Maar ik vraag me" ; "But it makes me"
	line "nu wel af." ; "question myself."
	
	para "Is er iets wat ik" ; "Is there something"
	line "verkeerd doe?" ; "I'm doing wrong?"

	para "Zou het kunnen dat" ; "Could it be that"
	line "liefde zijn team" ; "love made his"
	cont "zo machtig maakt?" ; "team so powerful?"
	done

ExecutiveM4BeforeText:
	text "Wat? Wie ben jij?" ; "What? Who are you?"
	line "Dit is het kantoor" ; "This is the office"

	para "van onze leider," ; "of our leader,"
	line "GIOVANNI." ; "GIOVANNI."

	para "Sinds het TEAM" ; "Since disbanding"
	line "ROCKET ontbonden" ; "TEAM ROCKET three"

	para "werd drie jaar" ; "years ago, he has"
	line "geleden, is hij" ; "been in hiding."
	cont "ondergedoken." ; 

	para "Maar we weten dat" ; "But we're certain"
	line "hij op een dag" ; "he will be back"

	para "vast terugkeert" ; "some day to assume"
	line "om ons te leiden." ; "command again."

	para "Ik laat je onze" ; "I won't let you"
	line "plannen niet" ; "interfere with"
	cont "doorkruisen!" ; "our plans!"
	done

ExecutiveM4BeatenText:
	text "Ik… Ik kon niets" ; "I… I couldn't do a"
	line "doen…" ; "thing…"

	para "GIOVANNI, vergeef" ; "GIOVANNI, please"
	line "me alsjeblieft…" ; "forgive me…"
	done

ExecutiveM4AfterText:
	text "Nee, dit mag me" ; "No, I can't let"
	line "niet deren." ; "this affect me."

	para "Ik moet de ander-" ; "I have to inform"
	line "en informeren…" ; "the others…"
	done

RocketBaseMurkrowText:
	text "MURKROW: Het" ; "MURKROW: The"
	line "wachtwoord is…" ; "password is…"

	para "LEVE GIOVANNI." ; "HAIL GIOVANNI."
	done

GruntF5SeenText:
	text "Weet ik het" ; "Do I know the"
	line "wachtwoord?" ; "password?"

	para "Misschien." ; "Maybe."

	para "Maar een zwakke-" ; "But no weakling's"
	line "ling krijgt het" ; "going to get it!"
	cont "niet!" ;
	done

GruntF5BeatenText:
	text "Goed. Stop." ; "All right. Stop."
	line "Ik zeg 't je." ; "I'll tell you."
	done

GruntF5AfterBattleText:
	text "Het wachtwoord" ; "The password to"
	line "voor de kamer van" ; "the boss's room is"
	cont "de baas is" ;

	para "SLOWPOKESTAART." ; "SLOWPOKETAIL."

	para "Maar je hebt er" ; "But it's useless"
	line "niks aan tenzij" ; "unless you have"
	cont "je twee wacht-" ; "two passwords."
	cont "woorden hebt." ;
	done

GruntM28SeenText:
	text "Hyuck-hyuck-hyuck!" ; "Hyuck-hyuck-hyuck!"

	para "Ik herken jou van" ; "I remember you"
	line "de SLOWPOKE WELL!" ; "from the well!"

	para "Je daagt me weer" ; "You're challenging"
	line "uit?" ; "me again?"

	para "Hah! Je bent gek," ; "Hah! You're nuts,"
	line "maar je hebt lef." ; "but you have guts!"

	para "Ik waarschuw je," ; "I'll warn you,"
	line "ik werd sterker." ; "I got better!"

	para "Als je me kan" ; "If you can beat"
	line "verslaan, vertel" ; "me, I'll tell you"

	para "ik je een wacht-" ; "a password to the"
	line "woord voor de" ; "boss's room!"
	cont "kamer van de baas!" ; 
	done

GruntM28BeatenText:
	text "Hja-ha-ha!" ; "Hyuck-hyuck-hyuck!"
	line "Je bent goed!" ; "You're good!"
	done

GruntM28AfterBattleText:
	text "Hja-ha-ha!" ; "Hyuck-hyuck-hyuck!"

	para "Het wachtwoord" ; "The password to"
	line "voor de kamer van" ; "the boss's room…"
	cont "de baas…" ;

	para "Uh…, volgens mij" ; "Uh…, I think it is"
	line "is het" ; "RATICATE TAIL."
	cont "RATICATE-STAART." ;
	done

ScientistRossSeenText:
	text "Ik werkte eerst" ; "I used to work for"
	line "voor SILPH, maar" ; "SILPH, but now I"

	para "nu leid ik onder-" ; "run research for"
	line "zoek voor TEAM" ; "TEAM ROCKET."
	cont "ROCKET." ;

	para "Een bemoeizuchtig" ; "A meddlesome child"
	line "kind als jij moet" ; "like you needs to"
	cont "gestraft worden." ; "be punished."
	done

ScientistRossBeatenText:
	text "Een tactische" ; "A mere tactical"
	line "fout kostte me" ; "error cost me…"
	cont "de kop…" ;
	done

ScientistRossAfterBattleText:
	text "Een radiosignaal" ; "A radio signal"
	line "dat #MON gek" ; "that drives #-"
	cont "maakt…" ; "MON mad…"

	para "Mijn experiment is" ; "My experiment is a"
	line "een groot succes." ; "complete success."

	para "Mijn promotie is" ; "My promotion is"
	line "gegarandeerd." ; "assured. This loss"

	para "Dit verlies be-" ; "means absolutely"
	line "tekent niets." ; "nothing."
	done

ScientistMitchSeenText:
	text "Het maakt me niet" ; "I don't care that"
	line "uit dat #MON" ; "#MON are hurt"
	cont "worden verwond bij" ; "by our experiment."
	cont "onze experimenten." ;
	done

ScientistMitchBeatenText:
	text "Ik ben beter" ; "Thinking is my"
	line "in denken dan" ; "strong suit, not"
	cont "in vechten." ; "battling."
	done

ScientistMitchAfterBattleText:
	text "Als we de sterkte" ; "If we turn up the"
	line "van ons radio-" ; "power of our radio"

	para "signaal wereld-" ; "signal for broad-"
	line "wijd verhogen…" ; "cast nationwide…"

	para "De gedachte alleen" ; "The very thought"
	line "al verheugt me!" ; "excites me!"
	done

TeamRocketBaseB3FLockedDoorNeedsPasswordText:
	text "De deur is op" ; "The door's closed…"
	line "slot…" ;

	para "Het heeft twee" ; "It needs two"
	line "wachtwoorden nodig" ; "passwords to open."
	cont "om te openen." ;
	done

TeamRocketBaseB3FLockedDoorOpenSesameText:
	text "De deur is op" ; "The door's closed…"
	line "slot…" ;

	para "<PLAYER> vulde de" ; "<PLAYER> entered"
	line "twee wachtwoorden" ; "the two passwords."
	cont "in." ;

	para "De deur opende!" ; "The door opened!"
	done

TeamRocketBaseB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  2, TEAM_ROCKET_BASE_B2F, 2
	warp_event 27,  2, TEAM_ROCKET_BASE_B2F, 3
	warp_event  3,  6, TEAM_ROCKET_BASE_B2F, 4
	warp_event 27, 14, TEAM_ROCKET_BASE_B2F, 5

	def_coord_events
	coord_event 10,  8, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossLeft
	coord_event 11,  8, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossRight
	coord_event  8, 10, SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER, RocketBaseRival

	def_bg_events
	bg_event 10,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 11,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 10,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 11,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 12,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 13,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  4, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  5, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  6, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  7, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript

	def_object_events
	object_event 25, 14, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LanceGetPasswordScript, EVENT_TEAM_ROCKET_BASE_B3F_LANCE_PASSWORDS
	object_event  8,  3, SPRITE_ARCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B3F_EXECUTIVE
	object_event  7,  2, SPRITE_MURKROW, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RocketBaseMurkrow, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21,  7, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, SlowpokeTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  5, 14, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, RaticateTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 23, 11, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerScientistRoss, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 11, 15, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerScientistMitch, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 24, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TeamRocketBaseB3FRocketScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  5, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_TEAM_ROCKET_BASE
	object_event  1, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FProtein, EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN
	object_event  3, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FXSpecial, EVENT_TEAM_ROCKET_BASE_B3F_X_SPECIAL
	object_event 28,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FFullHeal, EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL
	object_event 17,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FIceHeal, EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL
	object_event 14, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FUltraBall, EVENT_TEAM_ROCKET_BASE_B3F_ULTRA_BALL
