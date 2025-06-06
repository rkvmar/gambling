extends Node2D
var id = 0
@onready var sprite: AnimatedSprite2D = $DieSprite
const SHOP_TOOLTIP = preload("res://shop_tooltip.tscn")
var data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = int(name.split("endFace")[1])-1
	#print(id)
	data = Global.playerFaces[id]
	sprite.play(data["name"])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	var tooltip = SHOP_TOOLTIP.instantiate()
	tooltip.data = [data["name"], data["value"], data["tooltip"]]
	add_child(tooltip)


func _on_area_2d_mouse_exited() -> void:
	get_child(1).queue_free()
