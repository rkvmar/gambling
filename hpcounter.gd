extends RichTextLabel
var hp = 100
var max = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(name == "PlayerHP"):
		hp = Global.playerHP
		max = 100
		if(hp > max):
			Global.playerHP = 100
		if(hp < 0):
			Global.playerHP = 0
	else:
		hp = Global.opponentHP
		max = Global.opponentMax
		if(hp > max):
			Global.opponentHP = max
		if(hp < 0):
			Global.opponentHP = 0
	#if hp<0 and name == "OpponentCounter":
		#text = abs(hp)+'/'+str(max)
	#else: 
	text = str(hp)+'/'+str(max)
