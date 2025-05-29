extends Node2D
@onready var die_sprite: AnimatedSprite2D = $DieSprite
const SHOP_TOOLTIP = preload("res://shop_tooltip.tscn")
@onready var shop: Node2D = $".."
var data = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	data = Global.allFaces[randi_range(0,len(Global.allFaces)-1)]
	#print(data)
	die_sprite.play(data["name"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if(event.is_pressed()):
		#await get_tree().create_timer(2).timeout
		Global.shopSelection = data
	pass


func _on_area_2d_mouse_entered() -> void:
	var tooltip = SHOP_TOOLTIP.instantiate()
	tooltip.data = [data["name"], data["value"], data["tooltip"]]
	add_child(tooltip)


func _on_area_2d_mouse_exited() -> void:
	get_child(1).queue_free()
