extends Node
var playerTotal = 0
var opponentTotal = 0
var isRolling = false
var playerStand = false
var opponentStand = false
var standValue = 17
var rollOpponent = false
var canRoll = true
var canStand = true
var playerHP = 100
var opponentHP = 100
var opponentMax = 5
var addToOpponent = null
var addToPlayer = null
var level = 0
var shopSelection = null
var stopRoll = false
var resetting = false

var allFaces = [
	{
		"id": 0,
		"name": "1 dot",
		"value": 1,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 1,
		"name": "2 dots",
		"value": 2,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 2,
		"name": "3 dots",
		"value": 3,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 3,
		"name": "4 dots",
		"value": 4,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 4,
		"name": "5 dots",
		"value": 5,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 5,
		"name": "6 dots",
		"value": 6,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 6,
		"name": "7 dots",
		"value": 7,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 7,
		"name": "8 dots",
		"value": 8,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 8,
		"name": "9 dots",
		"value": 9,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"id": 9,
		"name": "knife",
		"value": 4,
		"tooltip": "on roll: deals 1 damage to opponent",
		"attributes": [{"type": "dmg", "value": 1, "on": "roll", "chance": 100}]
	},
	{
		"id": 10,
		"name": "heart",
		"value": 5,
		"tooltip": "on roll: heals 1 hp",
		"attributes": [{"type": "heal", "value": 1, "on": "roll", "chance": 100}]
	},
	{
		"id": 11,
		"name": "colon three",
		"value": 3,
		"tooltip": "on roll: gives a copy of this die to opponent",
		"attributes": [{"type": "addop", "value": 11, "on": "roll", "chance": 100}]
	},
	{
		"id": 12,
		"name": "pi",
		"value": 3,
		"tooltip": "on stand: rounds up",
		"attributes": [{"type": "rndup", "value": 1, "on": "stand", "chance": 100}]
	},
	{
		"id": 13,
		"name": "lucky clover",
		"value": 4,
		"tooltip": "on roll: 1/4 chance for instant blackjack",
		"attributes": [{"type": "instbj", "value": 1, "on": "roll", "chance": 25}]
	},
	{
		"id": 14,
		"name": "lucky seven",
		"value": 7,
		"tooltip": "on roll: 1/7 chance for instant blackjack",
		"attributes": [{"type": "instbj", "value": 1, "on": "roll", "chance": 14}]
	},
	{
		"id": 15,
		"name": "-1 dots",
		"value": -1,
		"tooltip": "negative die face",
		"attributes": []
	},
	{
		"id": 16,
		"name": "4 mana 7 7",
		"value": 4,
		"tooltip": "on hit: adds 4 to player, adds 7 to opponent",
		"attributes": [{"type": "addop", "value": 6, "on": "hit", "chance": 100},{"type": "addpl", "value": 3, "on": "hit", "chance": 100}]
	},
	{
		"id": 17,
		"name": "poke ball",
		"value": 3,
		"tooltip": "on roll: adds a random number face",
		"attributes": [{"type": "addpl", "value": [0,8], "on": "roll", "chance": 100, }]
	},
	{
		"id": 18,
		"name": "fire",
		"value": 8,
		"tooltip": "on hit: 1/3 chance to deal 1 damage",
		"attributes": [{"type": "dmg", "value": 1, "on": "hit", "chance": 33}]
	},
	{
		"id": 19,
		"name": "four of hearts",
		"value": 4,
		"tooltip": "on roll: heals both players 4 hp",
		"attributes": [{"type": "heal", "value": 4, "on": "roll", "chance": 100},{"type": "healop", "value": 4, "on": "roll", "chance": 100}]
	},
	{
		"id": 20,
		"name": "banana",
		"value": 6,
		"tooltip": "on roll: heals both players 1-3 hp",
		"attributes": [{"type": "heal", "value": [1,3], "on": "roll", "chance": 100, },{"type": "healop", "value": [1,3], "on": "roll", "chance": 100, }]
	},
	{
		"id": 21,
		"name": "wrench",
		"value": 1,
		"tooltip": "on hit: increase score by 1",
		"attributes": [{"type": "scorepl", "value": 1, "on": "hit", "chance": 100}]
	},	
	{
		"id": 22,
		"name": "skull",
		"value": 10,
		"tooltip": "on roll: deal 1 damage to both players",
		"attributes": [{"type": "dmg", "value": 1, "on": "roll", "chance": 100},{"type": "dmgpl", "value": 1, "on": "roll", "chance": 100}]
	},	
	{
		"id": 23,
		"name": "half die",
		"value": 0,
		"tooltip": "on stand: rounds up",
		"attributes": [{"type": "rndup", "value": 1, "on": "stand", "chance": 100}]
	},	
	{
		"id": 24,
		"name": "minus",
		"value": -2,
		"tooltip": "on roll: -1 from your opponent",
		"attributes": [{"type": "scoreop", "value": -1, "on": "roll", "chance": 100}]
	},	
	{
		"id": 25,
		"name": "french fries",
		"value": 8,
		"tooltip": "20% heal 10 hp, 20% heal opponent 5 hp",
		"attributes": [{"type": "heal", "value": 10, "on": "roll", "chance": 20},{"type": "healop", "value": 5, "on": "roll", "chance": 20}]
	},	
	{
		"id": 26,
		"name": "excalibur",
		"value": 21,
		"tooltip": "the strongest one.\n50% chance to deal 10 damage",
		"attributes": [{"type": "dmg", "value": 10, "on": "roll", "chance": 50}]
	},	
	{
		"id": 27,
		"name": "plus",
		"value": 2,
		"tooltip": "on roll: +1 to your opponent",
		"attributes": [{"type": "scoreop", "value": 1, "on": "roll", "chance": 100}]
	},
	{
		"id": 28,
		"name": "empty die",
		"value": 0,
		"tooltip": "does nothing?",
		"attributes": [{"type": "dmg", "value": 100, "on": "roll", "chance": 5}]
	},
	{
		"id": 29,
		"name": "brick",
		"value": 3,
		"tooltip": "on roll: deals 2 damage to both players",
		"attributes": [{"type": "dmg", "value": 2, "on": "roll", "chance": 100},{"type": "dmgpl", "value": 2, "on": "roll", "chance": 100}]
	},
]

var playerFaces = [
	{
		"name": "1 dot",
		"value": 1,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "2 dots",
		"value": 2,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "3 dots",
		"value": 3,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "4 dots",
		"value": 4,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "5 dots",
		"value": 5,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "6 dots",
		"value": 6,
		"tooltip": "standard die face",
		"attributes": []
	},
]
#var playerFaces = [
	#{
				#"id": 24,
				#"name": "minus",
				#"value": -2,
				#"tooltip": "on roll: -1 from your opponent",
				#"attributes": [{"type": "scoreop", "value": -1, "on": "roll", "chance": 100}]
			#},
#]
var playerCurrent = []

#var opponentFaces = [
	#{
		#"name": "1 dot",
		#"value": 1,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
	#{
		#"name": "2 dots",
		#"value": 2,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
	#{
		#"name": "3 dots",
		#"value": 3,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
	#{
		#"name": "4 dots",
		#"value": 4,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
	#{
		#"name": "5 dots",
		#"value": 5,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
	#{
		#"name": "6 dots",
		#"value": 6,
		#"tooltip": "standard die face",
		#"attributes": []
	#},
#]
var opponentCurrent = []

var opponents = [
	{
		"name" = "Intern",
		"hp" = 5,
		"stand" = 17,
		"faces" = [
			{
				"name": "1 dot",
				"value": 1,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "2 dots",
				"value": 2,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "3 dots",
				"value": 3,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "4 dots",
				"value": 4,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "5 dots",
				"value": 5,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "6 dots",
				"value": 6,
				"tooltip": "standard die face",
				"attributes": []
			},
		]
	},
	{
		"name" = "Guard",
		"hp" = 10,
		"stand" = 16,
		"faces" = [
			{
				"name": "1 dot",
				"value": 1,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "2 dots",
				"value": 2,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "3 dots",
				"value": 3,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"name": "8 dots",
				"value": 8,
				"tooltip": "standard die face",
				"attributes": []
			},
		]
	},
	{
		"name" = "Mechanic",
		"hp" = 20,
		"stand" = 17,
		"faces" = [
			{
				"name": "wrench",
				"value": 1,
				"tooltip": "on hit: increase score by 1",
				"attributes": [{"type": "scorepl", "value": 1, "on": "hit", "chance": 100}]
			},
			{
				"name": "fire",
				"value": 8,
				"tooltip": "on hit: 1/3 chance to deal 1 damage",
				"attributes": [{"type": "dmg", "value": 1, "on": "hit", "chance": 33}]
			},
			
		]
	},
	{
		"name" = "Gambler",
		"hp" = 30,
		"stand" = 15,
		"faces" = [
			{
				"name": "lucky clover",
				"value": 4,
				"tooltip": "on roll: 1/4 chance for instant blackjack",
				"attributes": [{"type": "instbj", "value": 1, "on": "roll", "chance": 25}]
			},
			{
				"name": "lucky seven",
				"value": 7,
				"tooltip": "on roll: 1/7 chance for instant blackjack",
				"attributes": [{"type": "instbj", "value": 1, "on": "roll", "chance": 14}]
			},
			{
				"name": "9 dots",
				"value": 9,
				"tooltip": "standard die face",
				"attributes": []
			},
		]
	},
	{
		"name" = "Wizard",
		"hp" = 40,
		"stand" = 15,
		"faces" = [
			{
				"name": "4 mana 7 7",
				"value": 4,
				"tooltip": "on hit: adds 4 to player, adds 7 to opponent",
				"attributes": [{"type": "addop", "value": 6, "on": "hit", "chance": 100},{"type": "addpl", "value": 3, "on": "hit", "chance": 100}]
			},
			{
				"name": "poke ball",
				"value": 3,
				"tooltip": "on roll: adds a random number face",
				"attributes": [{"type": "addpl", "value": [0,8], "on": "roll", "chance": 100, }]
			},
			{
				"name": "fire",
				"value": 8,
				"tooltip": "on hit: 1/3 chance to deal 1 damage",
				"attributes": [{"type": "dmg", "value": 1, "on": "hit", "chance": 33}]
			},
		]
	},
	{
		"name" = "Monkey",
		"hp" = 20,
		"stand" = 18,
		"faces" = [
			{
				"id": 20,
				"name": "banana",
				"value": 6,
				"tooltip": "on roll: heals both players 1-3 hp",
				"attributes": [{"type": "heal", "value": [1,3], "on": "roll", "chance": 100, },{"type": "healop", "value": [1,3], "on": "roll", "chance": 100, }]
			},
			{
				"id": 21,
				"name": "wrench",
				"value": 1,
				"tooltip": "on hit: increase score by 1",
				"attributes": [{"type": "scorepl", "value": 1, "on": "hit", "chance": 100}]
			},	
		]
	},
	{
		"name" = "Your Biggest Fan",
		"hp" = 40,
		"stand" = 16,
		"faces" = []
	},
	{
		"name" = "Mathemetician",
		"hp" = 60,
		"stand" = 17,
		"faces" = [
			{
				"id": 23,
				"name": "half die",
				"value": 0,
				"tooltip": "on stand: rounds up",
				"attributes": [{"type": "rndup", "value": 1, "on": "stand", "chance": 100}]
			},	
			{
				"id": 24,
				"name": "minus",
				"value": -2,
				"tooltip": "on roll: -1 from your opponent",
				"attributes": [{"type": "scoreop", "value": -1, "on": "roll", "chance": 100}]
			},
			{
				"id": 12,
				"name": "pi",
				"value": 3,
				"tooltip": "on stand: rounds up",
				"attributes": [{"type": "rndup", "value": 1, "on": "stand", "chance": 100}]
			},
			{
				"id": 21,
				"name": "wrench",
				"value": 1,
				"tooltip": "on hit: increase score by 1",
				"attributes": [{"type": "scorepl", "value": 1, "on": "hit", "chance": 100}]
			},	
			{
				"id": 7,
				"name": "8 dots",
				"value": 8,
				"tooltip": "standard die face",
				"attributes": []
			},
		]
	},
	{
		"name" = "Noah",
		"hp" = 80,
		"stand" = 17,
		"faces" = [
			{
				"id": 22,
				"name": "skull",
				"value": 10,
				"tooltip": "on hit: deal 1 damage to both players",
				"attributes": [{"type": "dmg", "value": 1, "on": "roll", "chance": 100},{"type": "dmgpl", "value": 1, "on": "roll", "chance": 100}]
			},	
			{
				"id": 9,
				"name": "knife",
				"value": 4,
				"tooltip": "on roll: deals 1 damage to opponent",
				"attributes": [{"type": "dmg", "value": 1, "on": "roll", "chance": 100}]
			},
			{
				"id": 10,
				"name": "heart",
				"value": 5,
				"tooltip": "on roll: heals 1 hp",
				"attributes": [{"type": "heal", "value": 1, "on": "roll", "chance": 100}]
			},
			{
				"id": 8,
				"name": "9 dots",
				"value": 9,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"id": 15,
				"name": "-1 dots",
				"value": -1,
				"tooltip": "negative die face",
				"attributes": []
			},
		]
	}, 
	{
		"name" = "CEO",
		"hp" = 100,
		"stand" = 17,
		"faces" = [
			{
				"id": 26,
				"name": "excalibur",
				"value": 21,
				"tooltip": "the strongest one.\n50% chance to deal 10 damage",
				"attributes": [{"type": "dmg", "value": 10, "on": "roll", "chance": 50}]
			},
			{ 
				"id": 15,
				"name": "-1 dots",
				"value": -1,
				"tooltip": "negative die face",
				"attributes": []
			},
			{
				"id": 15,
				"name": "-1 dots",
				"value": -1,
				"tooltip": "negative die face",
				"attributes": []
			},
			{
				"id": 15,
				"name": "-1 dots",
				"value": -1,
				"tooltip": "negative die face",
				"attributes": []
			},
			{
				"id": 0,
				"name": "1 dot",
				"value": 1,
				"tooltip": "standard die face",
				"attributes": []
			},
			{
				"id": 0,
				"name": "1 dot",
				"value": 1,
				"tooltip": "standard die face",
				"attributes": []
			},
		]
	},
	{
		"name" = "Building",
		"hp" = 200,
		"stand" = 18,
		"faces" = [
			{
				"id": 29,
				"name": "brick",
				"value": 3,
				"tooltip": "on roll: deals 2 damage to both players",
				"attributes": [{"type": "dmg", "value": 2, "on": "roll", "chance": 100},{"type": "dmgpl", "value": 2, "on": "roll", "chance": 100}]
			},
			{
				"id": 18,
				"name": "fire",
				"value": 8,
				"tooltip": "on hit: 1/3 chance to deal 1 damage",
				"attributes": [{"type": "dmg", "value": 1, "on": "hit", "chance": 33}]
			},
		]
	}
]

var dialog = [
		["> you wake up in a room", "> you don't remember how you got here", "> there's somebody standing near you", "intern> ugh i'm so bored...", "intern> do you know how to play blackjack?", "intern> i only have these dice on me though..."],
		["> you run out of the room towards the elevator","> you run into a guard","guard> you're not supposed to be here!"],
		["> you walk past the guard", "> you open the elevator doors", "> there's somebody inside", "mechanic> sorry, i'm working!"],
		["> you take the elevator up", "> you find yourself in rows of cubicles", "> you see somebody playing a game on their computer", "gambler> wait, who are you?", "gambler> i've never seen you before"],
		["> someone who looks extremely out of place in the office environment walks up to you","???> you seem to be having a lot of fun. can i play too?"],
		["> there's nothing of note on this floor", "> you get back in the elevator", "> there's a monkey in the elevator"],
		["> the elevator door opens   ", "> someone walks in after you", "> oh! i've been meaning to meet you for so long!"],
		["> someone taps you on the shoulder", "mathemetician> up for a game?"],
		["> you turn around and see someone looking extremely menacing", "> it smells strongly of steel", "> it glares at you, two red eyes locking into your soul", "noah> you're late", "noah> ..."],
		["> you go up to the top floor", "> time for some answers", "ceo> you know i'm not going to let you go, right?", "ceo> i'm too strong! i cannot lose!"],
		["ceo> you beat me.", "ceo> but i'm still not going to let you go.", "> the ceo presses a big red button on the table", "> you hear an explosion", "> the building starts crumbling"],
		["> you manage to get out of the building before it traps you inside","> you didn't see anyone else leave the building","> you escaped...", "> but at what cost?"]
	]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(isRolling):
		canRoll = false
	elif(playerStand):
		canRoll = false
	elif(Global.playerTotal >= 21):
		canRoll = false
	else: 
		canRoll = true
		
	if(isRolling or playerStand or playerTotal == 0):
		canStand = false
	else:
		canStand = true

func reset() -> void:
	playerTotal = 0
	opponentTotal = 0
	isRolling = false
	playerStand = false
	opponentStand = false
	standValue = 17
	rollOpponent = false
	canRoll = true
	canStand = true
	playerHP = 100
	opponentHP = 100
	opponentMax = 5
	addToOpponent = null
	addToPlayer = null
	level = 	0 
	shopSelection = null
	stopRoll = false
	resetting = false
	playerFaces = [
	{
		"name": "1 dot",
		"value": 1,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "2 dots",
		"value": 2,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "3 dots",
		"value": 3,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "4 dots",
		"value": 4,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "5 dots",
		"value": 5,
		"tooltip": "standard die face",
		"attributes": []
	},
	{
		"name": "6 dots",
		"value": 6,
		"tooltip": "standard die face",
		"attributes": []
	},
]
	get_tree().change_scene_to_file("res://dialog.tscn")

func changeScene(file) -> void:
	get_tree().change_scene_to_file(file)
