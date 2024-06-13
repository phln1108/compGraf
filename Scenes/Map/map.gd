extends Control
class_name Map

var explosion =  preload("res://Scenes/Explosion/explosion.tscn")

var can_drag: bool = false
var is_returned: bool = true
var velocity = 10

var boomEfect : AudioStream = preload("res://sounds/cardChose.wav")

@onready var ancor: Marker2D = $CardMenu/AncorPoint
@onready var card = $CardMenu/AncorPoint/Card

@onready var incomeBar = $ColorRect/incomeBar
@onready var educationBar = $ColorRect/educationBar
@onready var healthBar = $ColorRect/healthBar
@onready var socialBar = $ColorRect/socialBar

var motion: Vector2 = Vector2.ZERO

func _ready():
	$CardMenu/MainRect/cardContext.text = card.cardResource.text
	$yesMsg.setMsg(card.cardResource.yesMsg)
	$noMsg.setMsg(card.cardResource.noMsg)
	SignalBus.connect("cardSideChosed",on_card_chose_side)

func on_card_chose_side(sideChosed: Card.TextLabel ,values: Array[float], type: String) -> void:
	SoundManager.play(boomEfect)
	incomeBar.addValue(values[0])
	educationBar.addValue(values[1])
	healthBar.addValue(values[2])
	socialBar.addValue(values[3])
	
	$CardMenu/MainRect/cardContext.text = ""	
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
	$CardMenu/MainRect/cardContext.text = card.cardResource.text
	$yesMsg.setMsg(card.cardResource.yesMsg)
	$noMsg.setMsg(card.cardResource.noMsg)


func _process(delta):
	if can_drag and is_returned:
		var old_x = get_local_mouse_position().x - ancor.global_position.x
		old_x = clamp(old_x/3.5,-60,60)
		var x = abs(old_x)
		var y = (-0.02 * pow(x,2) + 5 * x) * 0.1 + x * 0.2
		if old_x < 0:
			x = -x
		card.position = Vector2(x+old_x,-y)
	else:
		if not card.global_position == ancor.global_position:
			motion = ancor.global_position - card.global_position
			card.global_position += motion*delta*velocity
			
func _on_card_dragging(is_dragging):
	can_drag = is_dragging

func _on_no_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.NO)
		incomeBar.valueHint_show(CardHandler.currentCard.noValues[0])
		educationBar.valueHint_show(CardHandler.currentCard.noValues[1])
		healthBar.valueHint_show(CardHandler.currentCard.noValues[2])
		socialBar.valueHint_show(CardHandler.currentCard.noValues[3])
		$noMsg.show = true

func _on_no_area_exited(area):
	if area is Card and area.textSelected == Card.TextLabel.NO:
		area.setText(Card.TextLabel.EMPTY)
		incomeBar.valueHint_hide()
		educationBar.valueHint_hide()
		healthBar.valueHint_hide()
		socialBar.valueHint_hide()
		$noMsg.show = false

func _on_yes_area_entered(area):
	if area is Card:
		area.setText(Card.TextLabel.YES)
		incomeBar.valueHint_show(CardHandler.currentCard.yesValues[0])
		educationBar.valueHint_show(CardHandler.currentCard.yesValues[1])
		healthBar.valueHint_show(CardHandler.currentCard.yesValues[2])
		socialBar.valueHint_show(CardHandler.currentCard.yesValues[3])
		$yesMsg.show = true

func _on_yes_area_exited(area):
	if area is Card and area.textSelected == Card.TextLabel.YES:
		area.setText(Card.TextLabel.EMPTY)
		incomeBar.valueHint_hide()
		educationBar.valueHint_hide()
		healthBar.valueHint_hide()
		socialBar.valueHint_hide()
		$yesMsg.show = false


func _on_config_button_pressed():
	PauseMenu.Pauseshow(self)
	


