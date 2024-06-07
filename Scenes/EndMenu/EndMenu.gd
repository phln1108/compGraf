extends Control

const barName: Array[String] = ["Finanças", "Educação", "Saúde", "Lazer"]

@onready var labelBarsVariation: Array[Label] = [$Variation/InV/InVNumber,
												$Variation/EdV/EdVNumber,
												$Variation/HeV/HeVNumber,
												$Variation/SoV/SoVNumber]
# Called when the node enters the scene tree for the first time.
func _ready():
	$span.text = "Você deixou a barra de "+ barName[Achievements.loseBar] +" cair Demais"
	for i in range(4):
		labelBarsVariation[i].text = str(Achievements.variations[i])
	$Card/CardsPLayed/CardPlayedNumber.text = str(Achievements.countCards)
	$Card/YesPlayed/YesPlayedNumber.text = str(Achievements.yesSideChosed)
	$Card/NoPlayed/NoPlayedNumber.text = str(Achievements.noSideChosed)



func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameMenu/game_menu.tscn")
