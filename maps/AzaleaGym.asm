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
	text "Ik ben BUGSY!" ; "I'm BUGSY!"
	line "Ik verlies nooit" ; "I never lose when"

	para "als het op insect" ; "it comes to bug"
	line "#MON aankomt." ; "#MON."

	para "Mijn onderzoek zal" ; "My research is"
	line "me de expert maken" ;" going to make me"

	para "aangaande insect" ; "the authority on"
	line "insect #MON!" ; "bug #MON!"
	
	para "Bijvoorbeeld, wist" ; "For example, did"
	line "je dat SNIJDEN " ; "you know that"
	
	para "eigenlijk een" ; "the move CUT is"
	line "INSECT-type aanval" ; "actually a BUG-"
	cont "is?" ; "type move?"
	
	para "Ik toon je al wat" ; "Let me demonstrate"
	line "ik geleerd heb van" ; "all I've learned"
	cont "mijn onderzoek." ; "from my studies."
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
	line "#MON tot L30" ; "#MON up to L30"

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
	text "Wauw, je bent de " ;" Wow, you're the"
	line "JOHTO KAMPIOEN nu!" ; "JOHTO CHAMPION"
	;cont "now!"

	para "Je vaardigheden" ; "Your skills are"
	line "zijn echt fameus." ; "truly impressive!"

	para "Ik ben druk bezig" ; "I've been busy"
	line "geweest met mijn" ; "with my research."
    cont "onderzoek."
	
	para "Ik ben klaar om je" ; "I'm ready to"
	line "mijn nieuwe ont-" ; "show you my new"
	cont "dekkingen te" ; "findings."
	cont "tonen."

	para "Wil je 't nog eens" ; "Want to have a"
	line "tegen me opnemen?" ; "rematch with me?"
	done

Bugsy_RematchDefeatText:
	text "Wauw, jij bent wel" ; "Wow, you must"
	line "een zeer ervaren"; "be an expert"
	cont "trainer."

	para "Mijn onderzoek is" ; "My research must"
	line "blijkbaar nog niet"
	cont "helemaal volledig…" ; "not be complete…"
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
	line "de GYMleider uit?" ; "challenging the"
	cont "Echt niet!" ; "LEADER? No way!"
	done

TwinsAmyandmay1BeatenText:
	text "AMY & MAY: Oh," ; "AMY & MAY: Oh,"
	line "je ziet dubbel!" ; "double goodness!"
	done

TwinsAmyandmay1AfterBattleText:
	text "AMY: Jij bent zeer" ; "AMY: You're"
	line "sterk! Maar BUGSY" ; "really strong!"

	para "is nog sterker! De" ; "But BUGSY's even"
	line "aanval SNIJD van" ;"stronger! His"

	para "zijn SCYTHER is" ; "SCYTHER's CUT al-"
	line "haast altijd een" ; "most always makes"
	cont "voltreffer!" ; "critical hits!"
	done

TwinsAmyandmay2SeenText:
	text "MAY: Je wil het" ; "MAY: You want to"
	line "tegen de GYMleider" ; "see the LEADER?"
	cont "opnemen? Succes!" ; "Good luck!"
	
	para "BUGSY is zo sterk!" ; "BUGSY is so"
	line "De aanval SNIJD" ; "strong! His"
	cont "van zijn SCYTHER" ; "SCYTHER's CUT"
	
	para "lijkt wel altijd" ; "always seems to"
	line "een voltreffer!" ; "crit!"
	done

TwinsAmyandmay2BeatenText:
	text "AMY & MAY: Oh," ; "AMY & MAY: Oh,"
	line "je ziet dubbel!" ; "double goodness!"
	done

TwinsAmyandmay2AfterBattleText:
	text "MAY: Onze insect" ; "MAY: Our bug #-"
	line "#MON verloren!" ; "MON lost! Oh, what"
	cont "Oh, wat jammer." ; "a shame."

	para "Die van BUGSY gaan" ; " BUGSY's won't"
	line "echter wel winnen!" ;" lose though!"

	para "Zijn PINECO maakt" ; "His PINECO makes"
	line "korte metten met" ; "short work of"
	cont "STEEN-type #-" ; "ROCK-type #MON!"
	cont "MON!"
	done

AzaleaGymGuideText:
	text "Yo, uitdager!" ; "Yo, challenger!"

	para "BUGSY is jong," ; "BUGSY's young, but"
	line "maar hij weet" ; "his knowledge of"

	para "veel van insect-" ; bug #MON is for"
	line "#MON." ; "real."

	para "Zonder mijn advies" ; "It's going to be"
	line "wordt het lastig" ; "tough without my"
	cont "voor je." ; "advice."

	para "Even denken…" ; "Let's see…"
	line "BUGSY's zakdrager" ; "BUGSY's bagworm"
	cont "#MON kent een" ; "#MON knows a"
	
	para "aanval die zijn" ; "move that covers"
	line "STEEN-type zwakte" ; "its ROCK-type"
	cont "dekt." ; "weakness."

	para "Hij heeft ook een" ; "He's also devel-"
	line "nieuwe INSECT-type" ; "oped a new"
	
	para "versie van SNIJD" ; "version of CUT"
	line "ontwikkeld" ; "that is BUG-type."

	para "Oh, en denk aan" ; "Oh, and don't"
	line "die lastige vol-" ; "forget about"

	para "treffers van 'm." ; "those nasty"
	line "Veel succes!" ; "critical hits!"
;
;	para "Good luck!"
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
