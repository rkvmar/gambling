extends Node2D
@onready var text: RichTextLabel = $Text
@onready var next_button: TextureButton = $NextButton
var stage = 0

func _ready() -> void:
	stage = 0
	print(Global.level)
	text.text = Global.dialog[Global.level][stage]


func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	if(stage == len(Global.dialog[Global.level])-1):
		if Global.level <= 10:
			Global.changeScene("res://game.tscn")	
		#elif Global.level == 11:
			#Global.level += 1
			#get_tree().change_scene_to_file("res://dialog.tscn")	
		else:
			Global.changeScene("res://win.tscn")	
	else:
		stage += 1
		text.text = text.text + "\n" + Global.dialog[Global.level][stage]
