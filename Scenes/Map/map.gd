extends Node2D

var can_drag: bool = false
var velocity = 450

var ancor: Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	ancor = $CardMenu/AncorPoint

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_drag:
		#$Card.global_position = get_global_mouse_position()
		#$Card.look_at($CardPoint/AncorPoint.global_position)
		ancor.look_at(get_global_mouse_position())
		ancor.rotation_degrees = clamp(ancor.rotation_degrees + 90 , -45, 45)
	else:
		if ancor.rotation_degrees > 0:
			ancor.rotation_degrees = clamp(ancor.rotation_degrees - (velocity * delta),0,180)
		elif ancor.rotation_degrees < 0:
			ancor.rotation_degrees = clamp(ancor.rotation_degrees + (velocity * delta),-180,0)
		
		#ancor.rotation_degrees = 0
func _on_card_dragging(is_dragging):
	can_drag = is_dragging

func _on_no_area_entered(area):
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
