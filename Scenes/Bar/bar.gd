@tool
extends Control

@export var icon: Texture
@export var value: float = 50
@export var id = 0

@onready var dot = $dot
@onready var bar = $bar

func _ready():
	bar.value = value
	dot.visible = false
	$icon.texture = icon

func valueHint_show(point: float):
	if !point:
		return
	dot.visible = true
	if point > 10:
		dot.scale = Vector2 (1.5,1.5)
		dot.position = Vector2(8,96) - (dot.size / 4)
		return
	dot.scale = Vector2(1,1)
	dot.position = Vector2(8,96)
func valueHint_hide():
	dot.visible = false
	
func addValue(point: float):
	value += point
	bar.value = value
	if value == 0:
		SignalBus.emit_signal("gameEnd",id)

func _process(delta):
	if is_inside_tree() and icon != $icon.texture:
		$icon.texture = icon
