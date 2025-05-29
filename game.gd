extends Node2D
@onready var opponent_name: RichTextLabel = $OpponentName
@onready var stand: RichTextLabel = $Stand
@onready var instructions: RichTextLabel = $instructions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.playerTotal = 0
	Global.opponentTotal = 0
	opponent_name.text = Global.opponents[Global.level]["name"]
	Global.opponentMax =  Global.opponents[Global.level]["hp"]
	Global.opponentHP = Global.opponentMax
	Global.playerCurrent = Global.playerFaces
	Global.opponentCurrent = Global.opponents[Global.level]["faces"]
	Global.standValue = Global.opponents[Global.level]["stand"]
	Global.playerHP += 10
	if(Global.level == 10):
		Global.playerHP = 100
	if(Global.opponents[Global.level]["name"] == "Your Biggest Fan"):
		Global.opponentCurrent = Global.playerFaces
	Global.opponentStand = false
	Global.playerStand = false
	Global.stopRoll = false
	Global.resetting = false
	if(Global.level	== 0):
		instructions.visible = true
	else:
		instructions.visible = false
	 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.opponentStand):
		stand.text = "Has Stood"
	else:
		stand.text = "Stands On "+str(Global.standValue)
