extends Control

@onready var backcreen: TextureRect = $BackScreen
@onready var label: Label = $ColorRect/MainLabel

var index: int = 0;

var texts: Array[String] = [
	"Olá! Aqui você entenderá melhor como funciona a mecânica do jogo.",
	
	"A mecânica central é baseada em cartas. Cada carta apresenta uma \
	situação ou uma escolha para você tomar.", 
	
	"Cada escolha afetará quatro pilares principais: \
	Finanças, Educação, Saúde e Lazer.",
	
	"Esses pilares, representados por medidores, \
	mostram o equilíbrio das influências. Se algum desses \
	medidores atingir o máximo ou o mínimo, o jogo termina.",
	
	"Deslize o centro das cartas para a esquerda ou para a direita, indicando sua \
	decisão sobre o assunto apresentado. ",
	
	"Cada escolha terá uma narrativa e pilares que seram influenciados.",
	
	"A quantidade na qual cada pilar será influenciado é representado pelo \
	circulo abaixo de cada pilar. Quanto maior o circulo, maior será a mudança nesse pilar.",
	
	"Tenha sempre em mente os valores dos seus pilares e as consequências de suas jogadas.",
	
	"Tenha um bom Jogo!"
]

var backScreens: Array[Texture] = [
	preload("res://assets/helpBackScreens/helpScreen.jpg"),
	null,
	null,
	preload("res://assets/helpBackScreens/helpScreen.jpg"),
	preload("res://assets/helpBackScreens/noChosed.jpg"),
	preload("res://assets/helpBackScreens/yesChosed.jpg"),
	preload("res://assets/helpBackScreens/yesChosed.jpg"),
	preload("res://assets/helpBackScreens/helpScreen.jpg"),
	null	
]

func _ready() -> void:
	sethelp()


func _on_backward_pressed() -> void:
	SoundManager.play()
	index -=1
	sethelp()
	$backward.visible = index != 0
	$foward.visible = index != len(texts) -1


func _on_foward_pressed() -> void:
	SoundManager.play()
	index +=1
	if index == len(texts):
		get_tree().change_scene_to_file("res://Scenes/GameMenu/game_menu.tscn")
		return
	sethelp()
	$backward.visible = index != 0
	
	
func sethelp() -> void:
	label.text = texts[index]
	if backScreens[index]:
		backcreen.texture = backScreens[index]
		
	for node in $hints.get_children():
		node.visible = false
		
	match index:
		2:
			$hints/barsHint.visible = true
		3:
			$hints/barsHint.visible = true
		6:
			$hints/dotHint.visible = true
