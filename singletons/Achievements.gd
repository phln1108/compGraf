extends Node

"""
o que colocar como chievements
- 

"""

var countCards: int = 0

var yesSideChosed: int = 0
var noSideChosed: int = 0

var variations: Array[float] = [0,0,0,0]
var decreaseValue: Array[float] = [0,0,0,0]
var increaseValue: Array[float] = [0,0,0,0]

var countTypes: int

func _ready() -> void:
	SignalBus.connect("cardSideChosed",on_card_chose_side)
	
	
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
	
	
	
	
