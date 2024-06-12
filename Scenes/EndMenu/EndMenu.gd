extends Control

const barName: Array[String] = ["Finanças", "Educação", "Saúde", "Lazer"]

var endTexts: Array[Array] = [[
	"Oh não! Você ficou sem dinheiro. As contas se acumularam e você não conseguiu \
	manter o equilíbrio financeiro. É hora de voltar à prancheta e aprender a \
	gerenciar melhor seus gastos!",
	
	"Oops! Seus estudos sofreram com sua falta de foco e dedicação. \
	Use essa experiência para se motivar a se dedicar mais.",
	
	"Sua saúde física e mental estão comprometidas. É hora de cuidar \
	de si mesmo e priorizar seu bem-estar. Lembre-se de que sem saúde, \
	as outras conquistas perdem o significado.",
	
	"Parece que você se esqueceu de se divertir um pouco. A vida não \
	é só trabalho e estudo. Reserve um tempo para relaxar e desfrutar das \
	coisas que te fazem feliz."
],[
	"Você acumulou uma grande fortuna, mas sua obsessão por riquezas deixou \
	você emocionalmente vazio e isolado, negligenciando o verdadeiro valor da vida.",
	
	"Seus estudos atingiram o ápice, mas sua busca incessante por conhecimento \
	obscureceu sua visão para as experiências além dos livros.",
	
	"Seu foco extremo na saúde alcançou um nível inigualável, mas isso veio com \
	um preço. Você sacrificou a felicidade em nome da perfeição física.",
	
	"Seu tempo de lazer foi explorado ao máximo, mas essa busca incessante por \
	prazer levou ao esgotamento físico e emocional, deixando-o vazio e insatisfeito."
]]


@onready var labelBarsVariation: Array[Label] = [$Variation/InV/InVNumber,
												$Variation/EdV/EdVNumber,
												$Variation/HeV/HeVNumber,
												$Variation/SoV/SoVNumber]
# Called when the node enters the scene tree for the first time.
func _ready():
	if Achievements.loseBar == -1:
		#var span: Label = $span
		$span.set("theme_override_colors/font_color",Color(0,255,0))
		$span.text = "Você conseguiu completar o Jogo. Parabens!"		
	else:
		$span.text = endTexts[int(Achievements.fromTop)][Achievements.loseBar]
	for i in range(4):
		labelBarsVariation[i].text = str(Achievements.barValues[i])
	$Card/CardsPLayed/CardPlayedNumber.text = str(Achievements.countCards)
	$Card/YesPlayed/YesPlayedNumber.text = str(Achievements.yesSideChosed)
	$Card/NoPlayed/NoPlayedNumber.text = str(Achievements.noSideChosed)



func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameMenu/game_menu.tscn")
