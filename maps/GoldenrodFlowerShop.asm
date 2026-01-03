	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA
	const GOLDENRODFLOWERSHOP_CLERK

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	opentext
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .SkipSquirtBottle
	checkflag ENGINE_PLAINBADGE
	iffalse .SkipSquirtBottle
	faceplayer
	writetext GoldenrodFlowerShopTeacherHeresTheSquirtbottleText
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
.SkipSquirtBottle
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .Lalala
	checkflag ENGINE_PLAINBADGE
	iffalse .NoPlainBadge
	checkevent EVENT_GOT_GOLD_BERRY_FROM_FLOWER_SHOP
	iftrue .GotReward
	faceplayer
	writetext GoldenrodFlowerShopTeacherHeresTheGoldBerryText
	promptbutton
	verbosegiveitem GOLD_BERRY
	setevent EVENT_GOT_GOLD_BERRY_FROM_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	closetext
	end
	
.GotReward
	sjump .Lalala

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	writetext GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText
	waitbutton
	closetext
	end

.GotSquirtbottle:
	jumptextfaceplayer GoldenrodFlowerShopTeacherDontDoAnythingDangerousText

.NoPlainBadge:
	faceplayer
	writetext GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText
	promptbutton
	checkevent EVENT_MET_FLORIA
	iffalse .HaventMetFloria
	closetext
	end

.HaventMetFloria:
	faceplayer
	writetext GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text
	waitbutton
	closetext
	end

FlowerShopFloriaScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	iffalse .TalkToFlorida
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .GotSquirtbottle
.TalkToFlorida
	writetext GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText
	waitbutton
	setevent EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP
	closetext
	end

.GotSquirtbottle:
	writetext GoldenrodFlowerShopFloriaYouBeatWhitneyText
	waitbutton
	closetext
	end

.FoughtSudowoodo:
	writetext GoldenrodFlowerShopFloriaItReallyWasAMonText
	waitbutton
	closetext
	end

FlowerShopShelf1: ; unreferenced
	jumpstd PictureBookshelfScript

FlowerShopShelf2: ; unreferenced
	jumpstd MagazineBookshelfScript

FlowerShopRadio: ; unreferenced
	jumpstd Radio2Script

BerryMartScript:
	faceplayer
	opentext
	readvar VAR_BADGES
	if_less_than 7, .NotSevenBadges
	sjump .SevenBadges
.NotSevenBadges
	pokemart MARTTYPE_STANDARD, MART_BERRYS
	sjump .end
.SevenBadges
	pokemart MARTTYPE_STANDARD, MART_BERRYS_2
.end
	closetext
	end

GoldenrodFlowerShopTeacherMySisterWentToSeeWigglyTreeRoute36Text:
	text "Heb je die" ; "Have you seen that"
	line "wiebelende boom" ; "wiggly tree that's"

	para "gezien die op" ; "growing on ROUTE"
	line "ROUTE 36 groeit?" ; "36?"

	para "Mijn zusje is" ; "My little sister"
	line "heel opgetogen" ; "got all excited"

	para "gaan kijken…" ; "and went to see"
	line "Ik maak me" ; "it…"

	para "zorgen. Is het" ; "I'm worried… Isn't"
	line "niet gevaarlijk?" ; "it dangerous?"
	done

GoldenrodFlowerShopTeacherAskWantToBorrowWaterBottleText:
	text "Wil jij ook" ; "Do you want to"
	line "de waterfles" ; "borrow the water"

	para "lenen? Ik wil" ; "bottle too?"
	line "niet dat je er" ; "I don't want you"

	para "iets gevaarlijks" ; "doing anything"
	line "mee doet." ; "dangerous with it."
	done

GoldenrodFlowerShopTeacherHeresTheSquirtbottleText:
	text "Oh, je bent beter" ; "Oh, you're better"
	line "dan WHITNEY…" ; "than WHITNEY…"

	para "Dan komt het" ; "You'll be OK,"
	line "goed. Hier is" ; "then. Here's the"
	cont "de SPUITFLES!" ; "SQUIRTBOTTLE!"
	done

GoldenrodFlowerShopTeacherHeresTheGoldBerryText:
	text "Oh, you"
	line "found FLORIA…"

	para "Here's a GOLD"
	line "BERRY as thanks!"
	done

GoldenrodFlowerShopTeacherDontDoAnythingDangerousText:
	text "Doe niets" ; "Don't do anything"
	line "gevaarlijks!" ; "too dangerous!"
	done

GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText:
	text "Lalala lalalala." ; "Lalala lalalala."
	line "Hier, veel water" ; "Have plenty of"
	cont "voor jou, liefje!" ; "water, my lovely!"
	done

GoldenrodFlowerShopFloriaWonderIfSisWillLendWaterBottleText:
	text "Toen ik mijn zus" ; "When I told my sis"
	line "over de wiebelende" ; "about the jiggly"

	para "boom vertelde, zei" ; "tree, she told me"
	line "ze dat het gevaar-" ; "it's dangerous."
	cont "lijk was." ;

	para "Als ik WHITNEY" ; "If I beat WHITNEY,"
	line "versla, kan ik" ; "I wonder if she'll"

	para "misschien haar" ; "lend me her water"
	line "waterfles lenen…" ; "bottle…"
	done

GoldenrodFlowerShopFloriaYouBeatWhitneyText:
	text "Wow, je hebt" ; "Wow, you beat"
	line "WHITNEY verslagen?" ; "WHITNEY? Cool!"
	cont "Cool!" ;
	done

GoldenrodFlowerShopFloriaItReallyWasAMonText:
	text "Dus het was echt" ; "So it really was a"
	line "een #MON!" ; "#MON!"
	done

GoldenrodFlowerShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, EVENT_FLORIA_AT_FLOWER_SHOP
	object_event  5,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BerryMartScript, -1
