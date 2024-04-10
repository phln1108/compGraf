extends Node2D

var can_drag: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_drag:
		$Card.global_position = get_global_mouse_position()
	else:
		$Card.global_position = $CardPoint.global_position


func _on_card_dragging(is_dragging):
	can_drag = is_dragging
