	object_const_def
	const GOLDENRODDEPTSTORE4F_CLERK
	const GOLDENRODDEPTSTORE4F_COOLTRAINER_M
	const GOLDENRODDEPTSTORE4F_BUG_CATCHER
	const GOLDENRODDEPTSTORE4F_GAMEBOY_KID

GoldenrodDeptStore4F_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodDeptStore4FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_4F
	closetext
	end

GoldenrodDeptStore4FCooltrainerMScript:
	jumptextfaceplayer GoldenrodDeptStore4FCooltrainerMText

GoldenrodDeptStore4FBugCatcherScript:
	jumptextfaceplayer GoldenrodDeptStore4FBugCatcherText

GoldenrodDeptStore4FGameboyKidScript:
	faceplayer
	opentext
	writetext GoldenrodDeptStore4FGameboyKidText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTORE4F_GAMEBOY_KID, DOWN
	end

GoldenrodDeptStore4FDirectory:
	jumptext GoldenrodDeptStore4FDirectoryText

GoldenrodDeptStore4FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodDeptStore4FCooltrainerMText:
	text "Hé. Ik hou van" ; "Hey. I love strong"
	line "sterke #MON." ; "#MON."

	para "Ik voed ze PRO-" ; "I feed them PRO-"
	line "TEÏNE om hun AAN-" ; "TEIN to crank up"
	cont "VAL op te hogen." ; "their ATTACK."
	done

GoldenrodDeptStore4FBugCatcherText:
	text "IJZER verhoogt je" ; "IRON adds to your"
	line "#MON's AFWEER." ; "#MON's DEFENSE."
	done

GoldenrodDeptStore4FGameboyKidText:
	text "Er deden geruchten" ; "There were"
	line "de ronde dat" ; "rumours that"

	para "sommige #MON" ; "some #MON"
	line "enkel evolueren na" ; "evolve only by"

	para "een ruil via de" ; "being traded via a"
	line "Game Link kabel." ; Game Link cable."

	para "Pfft..." ; "Pfft..."

	para "Wat een larie en" ; "Such"
	line "apenkool." ; "misinformation."

	para "Ik ken enkele" ; "I know some"
	line "#MON over wie" ; "of the rumoured"
	cont "dit gerucht gaat:" ; "#MON:"

	para "MACHOKE, KADABRA," ; "MACHOKE, KADABRA,"
	line "HAUNTER en, um,"  ; "HAUNTER and, um,"
	cont "GRAVELER," ; "GRAVELER,"

	para "maar ze evolueren" ; "but they all"
	line "allen door in" ; "evolve through"
	cont "niveau te groeien." ; "level up."

	para "Je #DEX toont" ; "Your #DEX shows"
	line "hoe #MON echt" ; "how #MON really"
	cont "evouleren!" ; "evolve!"
	done

GoldenrodDeptStore4FDirectoryText:
	text "Laat ons je #-" ; "Let Us Pump Up"
	line "MON versterken!" ; "Your #MON!"

	para "3V MEDICIJNDOOS" ; "4F MEDICINE BOX"
	done

GoldenrodDeptStore4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_5F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_3F, 2
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore4FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore4FElevatorButton

	def_object_events
	object_event 13,  5, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FClerkScript, -1
	object_event 11,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FCooltrainerMScript, -1
	object_event  7,  2, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FBugCatcherScript, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore4FGameboyKidScript, -1
