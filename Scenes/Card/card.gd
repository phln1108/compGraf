extends Node2D
class_name Card

@export var cardResource : JsonCard = null

@onready var cardContent = $CardContent

var draggable: bool = false
var is_dragging: bool = false
var inside: bool = false

var textSelected: TextLabel = TextLabel.EMPTY

enum TextLabel{EMPTY,YES,NO}

signal dragging

func _ready()-> void:
	cardResource = CardHandler.nex_card()
	newCard()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta)-> void:
	if draggable:
		if Input.get_action_strength("click") and draggable:
			#global_position = get_global_mouse_position()
			is_dragging = true
			dragging.emit(is_dragging)
		elif not Input.get_action_strength("click") and is_dragging:
			draggable = inside
			is_dragging = false
			dragging.emit(is_dragging)
			if  not textSelected == TextLabel.EMPTY:
				if textSelected == TextLabel.YES:
					SignalBus.emit_signal(	"cardSideChosed",textSelected,cardResource.yesValues,cardResource.type)
				else :
					SignalBus.emit_signal(	"cardSideChosed",textSelected,cardResource.noValues, cardResource.type)
				
				#await get_tree().create_timer(0.5).timeout
				var new_cardResource: JsonCard = CardHandler.nex_card()
				if !new_cardResource:
					return
				cardResource = new_cardResource
				newCard()

func newCard()-> void:
	cardContent.texture = cardResource.sprite
	
func setText(textlabel: TextLabel) -> void:
	textSelected = textlabel
	

func _on_mouse_entered()-> void:
	inside = true
	draggable = true
	
func _on_mouse_exited()-> void:
	inside = false
	draggable =  is_dragging
