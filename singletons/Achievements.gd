extends Node

"""
o que colocar como chievements
- 

"""
var loseBar: int = 0

var countCards: int = 0

var yesSideChosed: int = 0
var noSideChosed: int = 0

var variations: Array[float] = [0,0,0,0]
var decreaseValue: Array[float] = [0,0,0,0]
var increaseValue: Array[float] = [0,0,0,0]

var countTypes: int


func _ready() -> void:
	SignalBus.connect("cardSideChosed",on_card_chose_side)
	SignalBus.connect("gameEnd",on_game_end)
	
	
func on_card_chose_side(sideChosed: Card.TextLabel ,values: Array[float]) -> void:
	countCards+=1
	
	if sideChosed == Card.TextLabel.YES:
		yesSideChosed+=1
	else:
		noSideChosed+=1
		
	for i in range(4):
		if values[i] > 0:
			increaseValue[i] += values[i]
		else:
			decreaseValue[i] += values[i]
		variations[i] += abs(values[i])
		
func on_game_end(bar: int) -> void:
	loseBar = bar
	get_tree().change_scene_to_file("res://Scenes/EndMenu/EndMenu.tscn")
	
	
	
	
	
	
