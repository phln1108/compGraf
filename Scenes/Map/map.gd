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


func _on_no_area_entered(area):
	print(area)
	if area is Card:
		area.setText(Card.TextLabel.NO)


func _on_no_area_exited(area):
	if area is Card:
		area.setText(Card.TextLabel.EMPTY)


func _on_yes_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.YES)


func _on_yes_area_exited(area):
	if area is Card:
		area.setText(Card.TextLabel.EMPTY)
