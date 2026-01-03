	object_const_def
	const AZALEAGYM_BUGSY
	const AZALEAGYM_BUG_CATCHER1
	const AZALEAGYM_BUG_CATCHER2
	const AZALEAGYM_BUG_CATCHER3
	const AZALEAGYM_TWIN1
	const AZALEAGYM_TWIN2
	const AZALEAGYM_GYM_GUIDE

AzaleaGym_MapScripts:
	def_scene_scripts

	def_callbacks

AzaleaGymBugsyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BUGSY
	iftrue .FightDone
	writetext BugsyText_INeverLose
	waitbutton
	closetext
	winlosstext BugsyText_ResearchIncomplete, 0
	loadtrainer BUGSY, BUGSY1
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_BUGSY1
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_BUGSY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BUGSY
	opentext
	writetext Text_ReceivedHiveBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_HIVEBADGE
	checkflag ENGINE_HARD_MODE
	iffalse .DontUpdateBadge
	loadmem wLevelCap, 21 ; update level cap for hard mode
.DontUpdateBadge
	readvar VAR_BADGES
	scall AzaleaGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM49_FURY_CUTTER
	iftrue .GotFuryCutter
	setevent EVENT_BEAT_TWINS_AMY_AND_MAY
	setevent EVENT_BEAT_BUG_CATCHER_BENNY
	setevent EVENT_BEAT_BUG_CATCHER_AL
	setevent EVENT_BEAT_BUG_CATCHER_JOSH
	writetext BugsyText_HiveBadgeSpeech
	promptbutton
	verbosegiveitem TM_FURY_CUTTER
	iffalse .NoRoomForFuryCutter
	setevent EVENT_GOT_TM49_FURY_CUTTER
	writetext BugsyText_FuryCutterSpeech
	waitbutton
	closetext
	end

.GotFuryCutter:
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .NotBeatE4
	writetext BugsyRematchText
	yesorno
	iftrue .BugsyRematch
	sjump .NoRoomForFuryCutter
.NotBeatE4
	writetext BugsyText_BugMonsAreDeep
	waitbutton
.NoRoomForFuryCutter:
	closetext
	end

.BugsyRematch:
	special HealParty
	winlosstext Bugsy_RematchDefeatText, 0
	loadtrainer BUGSY, 2
	checkflag ENGINE_HARD_MODE
	iffalse .normalmode_2
	loadvar VAR_BATTLETYPE, BATTLETYPE_SETNOITEMS
.normalmode_2
	startbattle
	reloadmapafterbattle
	end


AzaleaGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerTwinsAmyandmay1:
	trainer TWINS, AMYANDMAY1, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay1SeenText, TwinsAmyandmay1BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext TwinsAmyandmay1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsAmyandmay2:
	trainer TWINS, AMYANDMAY2, EVENT_BEAT_TWINS_AMY_AND_MAY, TwinsAmyandmay2SeenText, TwinsAmyandmay2BeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext TwinsAmyandmay2AfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherBenny:
	trainer BUG_CATCHER, BUG_CATCHER_BENNY, EVENT_BEAT_BUG_CATCHER_BENNY, BugCatcherBennySeenText, BugCatcherBennyBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherBennyAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherAl:
	trainer BUG_CATCHER, AL, EVENT_BEAT_BUG_CATCHER_AL, BugCatcherAlSeenText, BugCatcherAlBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherAlAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherJosh:
	trainer BUG_CATCHER, JOSH, EVENT_BEAT_BUG_CATCHER_JOSH, BugCatcherJoshSeenText, BugCatcherJoshBeatenText, 0, .AfterScript

.AfterScript:
	endifjustbattled
	opentext
	writetext BugCatcherJoshAfterBattleText
	waitbutton
	closetext
	end

AzaleaGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_BUGSY
	iftrue .AzaleaGymGuideWinScript
	opentext
	writetext AzaleaGymGuideText
	waitbutton
	closetext
	end

.AzaleaGymGuideWinScript:
	opentext
	writetext AzaleaGymGuideWinText
	waitbutton
	closetext
	end

AzaleaGymStatue:
	checkflag ENGINE_HIVEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BUGSY, BUGSY1
	jumpstd GymStatue2Script

BugsyText_INeverLose:
	text "I'm BUGSY!"
	line "I never lose when"

	para "it comes to bug"
	line "#MON."

	para "My research is"
	line "going to make me"

	para "the authority on"
	line "bug #MON!"
	
	para "For example, did"
	line "you know that"
	
	para "the move CUT is"
	line "actually a BUG-"
	cont "type move?"
	
	para "Let me demonstrate"
	line "all I've learned"
	cont "from my studies."
	done

BugsyText_ResearchIncomplete:
	text "Wow, fantastich!" ; "Whoa, amazing!"
	line "Je bent echt een" ; "You're an expert"
	cont "#MON-expert!" ; "on #MON!"

	para "Ik ben nog lang" ; "My research isn't"
	line "niet uitgeleerd." ; "complete yet."

	para "OK, jij wint. Neem" ; "OK, you win. Take"
	line "deze badge." ; "this BADGE."
	done

Text_ReceivedHiveBadge:
	text "<PLAYER> ontving" ; "<PLAYER> received"
	line "KORFBADGE." ; "HIVEBADGE."
	done

BugsyText_HiveBadgeSpeech:
	text "Ken je de voor-" ; "Do you know the"
	line "delen van de" ; "benefits of HIVE-"
	cont "KORFBADGE?" ; "BADGE?"

	para "Hiermee zullen" ; "If you have it,"
	line "MON tot L30" ; "#MON up to L30"

	para "naar je luisteren," ; "will obey you,"
	line "ook geruilde." ; "even traded ones."

	para "Als je #MON met" ; "#MON that know"
	line "SNIJD hebt, werkt" ; "CUT will be able"

	para "dit ook buiten" ; "to use it outside"
	line "gevechten." ; "of battle too."

	para "Hier, deze mag je" ; "Here, I also want"
	line "ook van me hebben." ; "you to have this."
	done

BugsyText_FuryCutterSpeech:
	text "TM49 bevat" ; "TM49 contains"
	line "FURIESNIJDER." ; "FURY CUTTER."

	para "Als je niet mist," ; "If you don't miss,"
	line "wordt ie elke" ; "it gets stronger"
	cont "beurt sterker." ; "every turn."

	para "Hoe langer het" ; "The longer your"
	line "gevecht duurt, hoe" ; "battle goes, the"
	cont "beter het wordt." ; "better it gets."

	para "Is dat niet gaaf?" ; "Isn't that great?"
	line "Heb ik ontdekt!" ; "I discovered it!"
	done

BugsyText_BugMonsAreDeep:
	text "Over insect" ; "Bug #MON are"
	line "#MON zijn nog" ; "deep. There are"

	para "veel mysteries om" ; "many mysteries to"
	line "te ontrafelen." ; "be explored."

	para "Bestudeer je favo-" ; "Study your favor-"
	line "rieten uitvoerig." ; "ites thoroughly."
	done

BugsyRematchText:
	text "Wow, you're the"
	line "JOHTO CHAMPION"
	cont "now!"

	para "Your skills are"
	line "truly impressive!"

	para "I've been busy"
	line "with my research."

	para "I'm ready to"
	line "show you my new"
	cont "findings."

	para "Want to have a"
	line "rematch with me?"
	done

Bugsy_RematchDefeatText:
	text "Wow, you must"
	line "be an expert"
	cont "trainer."

	para "My research must"
	line "not be complete…"
	done

BugCatcherBennySeenText:
	text "Insect-#MON" ; "Bug #MON evolve"
	line "evolueren vroeg," ; "young. So they get"

	para "zodat ze sneller" ; "stronger that much"
	line "sterker worden." ; "faster."
	done

BugCatcherBennyBeatenText:
	text "Alleen evolueren" ; "Just evolving"
	line "is niet genoeg!" ; "isn't enough!"
	done

BugCatcherBennyAfterBattleText:
	text "#MON worden" ; "#MON become"
	line "sterker als ze" ; "stronger if they"
	cont "evolueren. Echt!" ; "evolve. Really!"
	done

BugCatcherAlSeenText:
	text "Insect-#MON" ; "Bug #MON are"
	line "zijn echt cool" ; "cool and tough!"

	para "en sterk! Ik zal" ; "I'll prove it to"
	line "het je bewijzen!" ; "you!"
	done

BugCatcherAlBeatenText:
	text "Je hebt bewezen" ; "You proved how"
	line "hoe sterk je bent…" ; "tough you are…"
	done

BugCatcherAlAfterBattleText:
	text "Ze zijn heel cool" ; "They're so cool,"
	line "maar veel meiden" ; "but most girls"

	para "houden niet van" ; "don't like bug"
	line "insect-#MON." ; "#MON."

	para "Geen idee waarom…" ; "I don't know why…"
	done

BugCatcherJoshSeenText:
	text "Je hebt alle SLOW-" ; "You saved all the"
	line "POKE gered? Tjee," ; "SLOWPOKE? Whew,"
	cont "indrukwekkend!" ; "you're mighty!"

	para "Maar mijn ge-" ; "But my grown-up"
	line "trainde #MON" ; "#MON are pretty"
	cont "zijn ook sterk!" ; "tough too!"
	done

BugCatcherJoshBeatenText:
	text "Urrgggh!" ; "Urrgggh!"
	done

BugCatcherJoshAfterBattleText:
	text "Ik moet ze" ; "I guess I should"
	line "betere aanvallen" ; "teach them better"
	cont "leren, denk ik…" ; "moves…"
	done

TwinsAmyandmay1SeenText:
	text "AMY: He! Daag jij" ; "AMY: Hi! Are you"
	line "de GYMLEIDER uit?" ; "challenging the"
	cont "Echt niet!" ; "LEADER? No way!"
	done

TwinsAmyandmay1BeatenText:
	text "AMY & MAY: Oh," ; "AMY & MAY: Oh,"
	line "je ziet dubbel!" ; "double goodness!"
	done

TwinsAmyandmay1AfterBattleText:
	text "AMY: You're"
	line "really strong!"

	para "But BUGSY's even"
	line "stronger! His"

	para "SCYTHER's CUT al-"
	line "most always makes"
	cont "critical hits!"
	done

TwinsAmyandmay2SeenText:
	text "MAY: You want to"
	line "see the LEADER?"
	cont "Good luck!"
	
	para "BUGSY is so"
	line "strong! His"
	cont "SCYTHER's CUT"
	
	para "always seems to"
	line "crit!"
	done

TwinsAmyandmay2BeatenText:
	text "AMY & MAY: Oh," ; "AMY & MAY: Oh,"
	line "je ziet dubbel!" ; "double goodness!"
	done

TwinsAmyandmay2AfterBattleText:
	text "MAY: Our bug #-"
	line "MON lost! Oh, what"
	cont "a shame."

	para "BUGSY's won't"
	line "lose though!"

	para "His PINECO makes"
	line "short work of"
	cont "ROCK-type #MON!"
	done

AzaleaGymGuideText:
	text "Yo, challenger!"

	para "BUGSY's young, but"
	line "his knowledge of"

	para "bug #MON is for"
	line "real."

	para "It's going to be"
	line "tough without my"
	cont "advice."

	para "Let's see…"
	line "BUGSY's bagworm"
	cont "#MON knows a"
	
	para "move that covers"
	line "its ROCK-type"
	cont "weakness."

	para "He's also devel-"
	line "oped a new"
	
	para "version of CUT"
	line "that is BUG-type."

	para "Oh, and don't"
	line "forget about"

	para "those nasty"
	line "critical hits!"

	para "Good luck!"
	done

AzaleaGymGuideWinText:
	text "Goed gedaan! Wat" ; "Well done! That"
	line "een spannende" ; "was a great clash"

	para "strijd tussen twee" ; "of talented young"
	line "jonge talenten." ; "trainers."

	para "De toekomst is" ; "With people like"
	line "rooskleurig met" ; "you, the future of"
	cont "trainers als jij!" ; "#MON is bright!"
	done

AzaleaGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, AZALEA_TOWN, 5
	warp_event  5, 15, AZALEA_TOWN, 5

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, AzaleaGymStatue
	bg_event  6, 13, BGEVENT_READ, AzaleaGymStatue

	def_object_events
	object_event  5,  7, SPRITE_BUGSY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaGymBugsyScript, -1
	object_event  5,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBugCatcherBenny, -1
	object_event  8,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherAl, -1
	object_event  0,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherJosh, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAmyandmay2, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, AzaleaGymGuideScript, -1
