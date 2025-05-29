extends Node2D
const SHOP_ITEM = preload("res://shopItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var selected = null
	print(Global.playerFaces)
	Global.playerCurrent = Global.playerFaces

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.shopSelection):
		#print(Global.shopSelection)
		Global.changeScene("res://player_faces.tscn")	
		#Global.playerFaces.append(Global.shopSelection)
		#print(Global.playerFaces)
		#Global.level += 1
		#get_tree().change_scene_to_file("res://dialog.tscn")	


func _on_skip_button_pressed() -> void:
	Global.level += 1
	Global.changeScene("res://dialog.tscn")	
