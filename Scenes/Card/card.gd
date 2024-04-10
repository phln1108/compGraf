extends Node2D
class_name Card

var draggable: bool = false
var is_dragging: bool = false

signal dragging

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		if Input.is_action_pressed("click") and !is_dragging:
			#global_position = get_global_mouse_position()
			is_dragging = true
			emit_signal("dragging",is_dragging)
		elif  Input.is_action_just_released("click") and is_dragging:
			is_dragging = false
			emit_signal("dragging",is_dragging)



func _on_area_2d_mouse_entered():
	draggable = true


func _on_area_2d_mouse_exited():
	draggable = is_dragging 
