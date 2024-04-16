extends Node

var cardsFolder = DirAccess.open("res://Resources/Cards/")
var cards: Array[CardResource]

var currentCard: CardResource

func _ready():
	cardsFolder.list_dir_begin()
	while (true) :
		var file_name = cardsFolder.get_next()
		if file_name == "":
			break
		cards.append(load(cardsFolder.get_current_dir()+"/"+file_name))
		print(cards)
		print(cardsFolder.get_current_dir()+file_name)

func nex_card():
	currentCard = cards.pop_front()
	return currentCard
