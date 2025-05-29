extends Node2D
const dieScene = preload("res://die.tscn")
var numDice = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.addToOpponent != null):
		#print(Global.addToOpponent)
		addDie(Global.addToOpponent)
		Global.addToOpponent = null
	if(numDice > 14):
		Global.opponentStand = true


func _on_player_die_container_roll_opponent() -> void:
	if not Global.resetting:
		get_tree().call_group("opponent", "hit")
		var die = dieScene.instantiate()
		die.position = Vector2i(90-5*numDice,40)
		die.add_to_group("opponent")
		add_child(die)
		die.roll(Global.opponentCurrent)
		numDice += 1
	
func addDie(face) -> void:
	var die = dieScene.instantiate()
	die.position = Vector2i(90-5*numDice,40)
	die.add_to_group("opponent")
	add_child(die)
	die.add(face)
	numDice += 1


func _on_player_die_container_reset_opponent() -> void:
	#var children = get_children()
	#var childreninv =[]
	#for i in children:
		#childreninv.push_front(i)
	##print(childreninv)
	#for n in childreninv:
		#if(n):
			#n.queue_free()
		#await get_tree().create_timer(0.03).timeout
	numDice = 0
