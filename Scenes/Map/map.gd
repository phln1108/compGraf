extends Control
class_name Map

var explosion =  preload("res://Scenes/Explosion/explosion.tscn")

var can_drag: bool = false
var is_returned: bool = true
var velocity = 450

@onready var ancor: Marker2D = $CardMenu/AncorPoint
@onready var card = $CardMenu/AncorPoint/Card


@onready var incomeBar = $ColorRect/incomeBar
@onready var educationBar = $ColorRect/educationBar
@onready var healthBar = $ColorRect/healthBar
@onready var socialBar = $ColorRect/socialBar


func _ready():
	SignalBus.connect("cardSideChosed",on_card_chose_side)

func on_card_chose_side(textSelected,values):
	incomeBar.addValue(values[0])
	educationBar.addValue(values[1])
	healthBar.addValue(values[2])
	socialBar.addValue(values[3])
	
	var instance = explosion.instantiate()
	add_child(instance)
	instance.z_index = 10
	instance.global_position = card.global_position 
	instance.connect("end",on_boom_end)	
	instance.boom()
	ancor.visible = false
	is_returned = false
	
func on_boom_end():
	var instance = explosion.instantiate()
	add_child(instance)
	instance.z_index = 10
	instance.global_position = card.global_position 
	instance.boom()
	await get_tree().create_timer(0.2).timeout
	ancor.visible = true
	is_returned = true

func _process(delta):
	if can_drag and is_returned:
		ancor.look_at(get_global_mouse_position())
		ancor.rotation_degrees = clamp(ancor.rotation_degrees + 90 , -45, 45)
	else:
		if ancor.rotation_degrees > 0:
			ancor.rotation_degrees = clamp(ancor.rotation_degrees - (velocity * delta),0,180)
		elif ancor.rotation_degrees < 0:
			ancor.rotation_degrees = clamp(ancor.rotation_degrees + (velocity * delta),-180,0)
		
func _on_card_dragging(is_dragging):
	can_drag = is_dragging

func _on_no_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.NO)
		incomeBar.valueHint_show(CardHandler.currentCard.noValues[0])
		educationBar.valueHint_show(CardHandler.currentCard.noValues[1])
		healthBar.valueHint_show(CardHandler.currentCard.noValues[2])
		socialBar.valueHint_show(CardHandler.currentCard.noValues[3])

func _on_no_area_exited(area):
	if area is Card and area.textSelected == Card.TextLabel.NO:
		area.setText(Card.TextLabel.EMPTY)
		incomeBar.valueHint_hide()
		educationBar.valueHint_hide()
		healthBar.valueHint_hide()
		socialBar.valueHint_hide()

func _on_yes_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.YES)
		incomeBar.valueHint_show(CardHandler.currentCard.yesValues[0])
		educationBar.valueHint_show(CardHandler.currentCard.yesValues[1])
		healthBar.valueHint_show(CardHandler.currentCard.yesValues[2])
		socialBar.valueHint_show(CardHandler.currentCard.yesValues[3])

func _on_yes_area_exited(area):
	if area is Card and area.textSelected == Card.TextLabel.YES:
		area.setText(Card.TextLabel.EMPTY)
		incomeBar.valueHint_hide()
		educationBar.valueHint_hide()
		healthBar.valueHint_hide()
		socialBar.valueHint_hide()


func _on_config_button_pressed():
	PauseMenu.Pauseshow(self)
