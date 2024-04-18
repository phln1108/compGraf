extends Node

"""
o que colocar como chievements
- 

"""

var countCards: int = 0

var yesSideChosed: int = 0
var noSideChosed: int = 0

var educationVariation: float = 0
var incomeVariation: float = 0
var healthVariation: float = 0
var socialVariation: float = 0

func _ready():
	SignalBus.connect("cardSideChosed",on_card_chose_side)
	
	
func on_card_chose_side(textSelected,education,health,income,social):
	countCards+=1
	
	if textSelected == Card.TextLabel.YES:
		yesSideChosed+=1
	else:
		noSideChosed+=1
		
	educationVariation += abs(education)
	incomeVariation += abs(income)
	healthVariation += abs(health)
	socialVariation += abs(social)

	
	
