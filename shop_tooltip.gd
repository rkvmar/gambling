extends Node2D
var data = ["title","value","tooltip"]

@onready var title: RichTextLabel = $Sprite2D/Name
@onready var value: RichTextLabel = $Sprite2D/Value
@onready var description: RichTextLabel = $Sprite2D/Description


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	title.text = '[center]'+data[0]
	value.text = '[center]'+str(data[1])
	description.text = '[center]'+data[2]
