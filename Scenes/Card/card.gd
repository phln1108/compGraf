extends Node2D
class_name Card

@export var cardResource : CardResource = null

@onready var contentLabel = $ContentLabel
@onready var cardContent = $CardContent
@onready var responseLabel = $ResponseLabel

var draggable: bool = false
var is_dragging: bool = false

var textSelected: TextLabel = TextLabel.EMPTY

enum TextLabel{EMPTY,YES,NO}

signal dragging

func _ready():
	setText(TextLabel.EMPTY)
	cardResource = CardHandler.nex_card()
	newCard()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable:
		if Input.is_action_pressed("click"):
			#global_position = get_global_mouse_position()
			is_dragging = true
			emit_signal("dragging",is_dragging)
		elif  Input.is_action_just_released("click") and is_dragging:
			is_dragging = false
			emit_signal("dragging",is_dragging)
			if  not textSelected == TextLabel.EMPTY:
				if textSelected == TextLabel.YES:
					SignalBus.emit_signal(	"cardSideChosed",
											textSelected,
											cardResource.yesEducation,
											cardResource.yesHealth,
											cardResource.yesIncome,
											cardResource.yesSocial
					)
				else :
					SignalBus.emit_signal(	"cardSideChosed",
											textSelected,
											cardResource.noEducation,
											cardResource.noHealth,
											cardResource.noIncome,
											cardResource.noSocial
					)
				var new_cardResource = CardHandler.nex_card()
				if !new_cardResource:
					return
				cardResource = new_cardResource
				newCard()
	
func setText(textlabel: TextLabel):
	textSelected = textlabel
	match(textlabel):
		TextLabel.EMPTY:
			responseLabel.text = ""
		TextLabel.YES:
			responseLabel.text = cardResource.yesMsg
		TextLabel.NO:
			responseLabel.text = cardResource.noMsg

func newCard():
	contentLabel.text = cardResource.text
	cardContent.texture = cardResource.sprite

func _on_mouse_entered():
	draggable = true
	
func _on_mouse_exited():
	draggable = is_dragging 
