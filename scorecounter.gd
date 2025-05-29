extends RichTextLabel
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(name == "PlayerCounter"):
		score = Global.playerTotal
	else:
		score = Global.opponentTotal
	if score<0 and name == "OpponentCounter":
		text = str(abs(score))+'/21-'
	else: 
		text = str(score)+'/21'
