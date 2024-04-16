extends Node2D

var can_drag: bool = false
var velocity = 450

@onready var ancor: Marker2D = $CardMenu/AncorPoint

@onready var incomeBar = $ColorRect/IncomeBar
@onready var educationBar = $ColorRect/EducationBar
@onready var healthBar = $ColorRect/HealthBar
@onready var socialBar = $ColorRect/SocialBar


func _ready():
	SignalBus.connect("cardSideChosed",on_card_chose_side)


func on_card_chose_side(textSelected,education,health,income,social):
	incomeBar.value += income
	educationBar.value += education
	healthBar.value += health
	socialBar.value += social

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
	if area is Card and area.textSelected == Card.TextLabel.NO:
		area.setText(Card.TextLabel.EMPTY)

func _on_yes_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.YES)

func _on_yes_area_exited(area):
	if area is Card and area.textSelected == Card.TextLabel.YES:
		area.setText(Card.TextLabel.EMPTY)
