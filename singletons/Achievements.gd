extends Node

var loseBar: int = -1
var fromTop: bool = false

var countCards: int = 0

var yesSideChosed: int = 0
var noSideChosed: int = 0

var variations: Array[float] = [0,0,0,0]
var decreaseValue: Array[float] = [0,0,0,0]
var increaseValue: Array[float] = [0,0,0,0]

var barValues: Array[float] = [50,50,50,50]

var countTypes: int

func _ready() -> void:
	SignalBus.connect("restartGame",onRestart)
	SignalBus.connect("cardSideChosed",on_card_chose_side)
	SignalBus.connect("gameEnd",on_game_end)
	
	
func on_card_chose_side(sideChosed: Card.TextLabel ,values: Array[float], type: String) -> void:
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
		
func on_game_end(bar: int,top:bool) -> void:
	loseBar = bar
	fromTop = top
	get_tree().change_scene_to_file("res://Scenes/EndMenu/EndMenu.tscn")
	
func setBarValue(bar:int, value: float) -> void:
	barValues[bar] = clamp(value,0,100);
	
func onRestart() -> void:
	loseBar = -1
	fromTop = false

	countCards = 0

	yesSideChosed = 0
	noSideChosed = 0

	variations = [0,0,0,0]
	decreaseValue = [0,0,0,0]
	increaseValue = [0,0,0,0]

	barValues = [50,50,50,50]
	
	
