extends Node2D
@onready var dieSprite: AnimatedSprite2D = $DieSprite
const SHOP_TOOLTIP = preload("res://shop_tooltip.tscn")
var chosenface
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if(is_in_group("player")):
		#roll(Global.playerFaces)
	#if(is_in_group("opponent")):
		#roll(Global.opponentFaces)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _input(event):
	#if event.is_action_pressed("roll"):
		#if(not isRolling):
			#roll(faces)

func roll(fcs) -> void:
	var i=0
	var rand = 0
	while(i<10):
		rand = randi_range(0,len(fcs)-1)
		chosenface = fcs[rand]
		dieSprite.play(chosenface["name"])
		i+=1
		await get_tree().create_timer(0.025).timeout
	#print(values[rand])
	if(is_in_group("player")):
		Global.playerTotal += chosenface["value"]
		execute("roll")
	if(is_in_group("opponent")):
		Global.opponentTotal += chosenface["value"]
		execute("roll")
		if(Global.opponentTotal >= Global.standValue and not Global.opponentStand):
			Global.opponentStand = true
			get_tree().call_group("opponent", "stand")
			if(Global.playerStand):
				Global.stopRoll = true
		elif(Global.playerStand and not Global.stopRoll):
			Global.rollOpponent = true
		Global.isRolling = false


func add(face) -> void:
	chosenface = Global.allFaces[face]
	dieSprite.play(chosenface["name"])
	if(is_in_group("player")):
		Global.playerTotal += chosenface["value"]
	if(is_in_group("opponent")):
		Global.opponentTotal += chosenface["value"]
		if(Global.opponentTotal >= Global.standValue and not Global.opponentStand):
			get_tree().call_group("opponent", "stand")
			Global.opponentStand = true


func execute(on) -> void:
	for attribute in chosenface["attributes"]:
		var value = attribute["value"]
		#print(attribute)
		if(attribute["value"] is Array):
			value = randi_range(attribute["value"][0], attribute["value"][1])
		if(attribute["on"] == on):
			if(randi_range(1,100) <= attribute["chance"]):
				if(attribute["type"] == "heal"):
					if(is_in_group("player")):
						Global.playerHP += value
					if(is_in_group("opponent")):
						Global.opponentHP += value
				if(attribute["type"] == "healop"):
					if(is_in_group("opponent")):
						Global.playerHP += value
					if(is_in_group("player")):
						Global.opponentHP += value
				if(attribute["type"] == "dmg"):
					if(is_in_group("player")):
						Global.opponentHP -= value
					if(is_in_group("opponent")):
						Global.playerHP -= value
				if(attribute["type"] == "dmgpl"):
					if(is_in_group("opponent")):
						Global.opponentHP -= value
					if(is_in_group("player")):
						Global.playerHP -= value
				if(attribute["type"] == "instbj"):
					if(is_in_group("player")):
						Global.playerTotal = 21
					if(is_in_group("opponent")):
						Global.opponentTotal = 21
				if(attribute["type"] == "rndup"):
					if(is_in_group("player")):
						if(Global.playerTotal < 21):
							Global.playerTotal += 1
					if(is_in_group("opponent")):
						if(Global.opponentTotal < 21):
							Global.opponentTotal += 1
				if(attribute["type"] == "addop"):
					if(is_in_group("player")):
						Global.addToOpponent = value
						#Global.opponentCurrent.append(Global.allFaces[attribute["value"]])
					if(is_in_group("opponent")):
						Global.addToPlayer = value
						#Global.playerCurrent.append(Global.allFaces[attribute["value"]])
				if(attribute["type"] == "addpl"):
					if(is_in_group("opponent")):
						Global.addToOpponent = value
						#Global.opponentCurrent.append(Global.allFaces[attribute["value"]])
					if(is_in_group("player")):
						Global.addToPlayer = value
						#Global.playerCurrent.append(Global.allFaces[attribute["value"]])
				if(attribute["type"] == "scorepl"):
					if(is_in_group("player")):
						Global.playerTotal += value
					if(is_in_group("opponent")):
						Global.opponentTotal += value
				if(attribute["type"] == "scoreop"):
					if(is_in_group("opponent")):
						Global.playerTotal += value
					if(is_in_group("player")):
						Global.opponentTotal += value
	if(Global.opponentTotal >= Global.standValue and !Global.opponentStand and on != "stand"):
		get_tree().call_group("opponent", "stand")
		Global.opponentStand = true


func stand() -> void:
	execute("stand")

func hit() -> void:
	execute("hit")


func _on_control_mouse_entered() -> void:
	var tooltip = SHOP_TOOLTIP.instantiate()
	tooltip.data = [chosenface["name"], chosenface["value"], chosenface["tooltip"]]
	add_child(tooltip)


func _on_control_mouse_exited() -> void:
	get_child(-1).queue_free()

func destroy() -> void:
	queue_free()
