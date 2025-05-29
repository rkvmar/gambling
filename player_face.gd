extends Node2D
var id = 0
@onready var sprite: AnimatedSprite2D = $DieSprite
const SHOP_TOOLTIP = preload("res://shop_tooltip.tscn")
var data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = int(name.split("playerFace")[1])-1
	#print(id)
	data = Global.playerFaces[id]
	sprite.play(data["name"])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event.is_pressed()):
		Global.playerFaces[id] = Global.shopSelection
		Global.shopSelection = null
		#print(Global.playerFaces)
		Global.level += 1
		Global.changeScene("res://dialog.tscn")	


func _on_area_2d_mouse_entered() -> void:
	var tooltip = SHOP_TOOLTIP.instantiate()
	tooltip.data = [data["name"], data["value"], data["tooltip"]]
	add_child(tooltip)


func _on_area_2d_mouse_exited() -> void:
	get_child(1).queue_free()
