extends Node2D
const dieScene = preload("res://die.tscn")

var numDice = 0

signal rollOpponent
signal resetOpponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _input(event) -> void:
	if event.is_action_pressed("roll"):
		if(Global.canRoll):
			roll()
	if event.is_action_pressed("stand"):
		if(Global.canStand):
			stand()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(get_tree()):
		if(Global.rollOpponent):
			Global.rollOpponent = false
			if(not Global.stopRoll):
				await get_tree().create_timer(0.5).timeout
				emit_signal("rollOpponent")
		if(Global.playerStand and Global.opponentStand):
			Global.stopRoll = true
			if not Global.resetting:
				reset()
		if(Global.addToPlayer != null):
			addDie(Global.addToPlayer)
			Global.addToPlayer = null
		if(Global.playerHP <= 0):
			Global.stopRoll = true
			await get_tree().create_timer(0.5).timeout
			Global.changeScene("res://death.tscn")
		elif(Global.opponentHP <= 0):
			Global.stopRoll = true
			await get_tree().create_timer(0.5).timeout
			if(Global.level >= 9):
				Global.level += 1
				Global.changeScene("res://dialog.tscn")	
			else:
				Global.changeScene("res://shop.tscn")	
		
func roll() -> void:
	get_tree().call_group("player", "hit")
	if(not Global.isRolling):
		Global.isRolling = true
		var die = dieScene.instantiate()
		die.position = Vector2i(-90+5*numDice,40)
		die.add_to_group("player")
		add_child(die)
		die.roll(Global.playerCurrent)
		numDice += 1
		await get_tree().create_timer(0.5).timeout
		if(not Global.opponentStand and not Global.stopRoll):
			Global.rollOpponent = true
		else:
			Global.isRolling = false

func addDie(value) -> void:
	Global.isRolling = true
	var die = dieScene.instantiate()
	die.position = Vector2i(-90+5*numDice,40)
	die.add_to_group("player")
	add_child(die)
	die.add(value)
	numDice += 1

func stand() -> void:
	get_tree().call_group("player", "stand")
	if(not Global.playerStand):
		Global.playerStand = true
		if(not Global.opponentStand and not Global.stopRoll):
			Global.rollOpponent = true

func _on_hit_button_pressed() -> void:
	roll()


func _on_stand_button_pressed() -> void:
	stand()

func reset() -> void:
	Global.resetting = true
	Global.stopRoll = true
	Global.opponentStand = false
	await get_tree().create_timer(0.5).timeout
	if(Global.playerTotal > 21):
		Global.playerTotal = 0
	if(Global.opponentTotal > 21):
		Global.opponentTotal = 0
	if(Global.playerTotal > Global.opponentTotal):
		Global.opponentHP -= (Global.playerTotal - Global.opponentTotal)
	if(Global.opponentTotal > Global.playerTotal):
		Global.playerHP -= (Global.opponentTotal - Global.playerTotal)
	await get_tree().create_timer(0.5).timeout
	Global.playerTotal = 0
	Global.opponentTotal = 0
	get_tree().call_group("player", "destroy")
	get_tree().call_group("opponent", "destroy")
	#for n in get_children():
		#remove_child(n)
		#n.queue_free()
		#await get_tree().create_timer(0.05).timeout
	numDice = 0
	emit_signal("resetOpponent")
	if(get_tree()):
		await get_tree().create_timer(0.5).timeout
	Global.playerStand = false
	Global.stopRoll = false
	Global.resetting = false
