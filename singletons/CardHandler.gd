extends Node

var cards: Array[CardResource]

var currentCard: CardResource

func _ready() -> void:
	var dataFile = FileAccess.open("res://cards.json",FileAccess.READ)
	var parsed = JSON.parse_string(dataFile.get_as_text())
	
	var cardsFolder = DirAccess.open("res://assets/cardIcons/")
	cardsFolder.list_dir_begin()
	var files = []
	var file_name = cardsFolder.get_next()
	while file_name != "":
		if !cardsFolder.current_is_dir():
			if file_name.ends_with(".png") or file_name.ends_with(".jpg") or file_name.ends_with(".jpeg"):
				files.append("res://assets/cardIcons/" + file_name)
		file_name = cardsFolder.get_next()
		
	for cardJson in parsed:
		var new_card: CardResource = CardResource.new()
		
		var random_index = randi() % files.size()
		new_card.sprite = load(files[random_index])
		new_card.text = cardJson["text"]
		new_card.yesMsg = cardJson["yesMsg"]
		new_card.noMsg = cardJson["noMsg"]
		new_card.yesEducation = cardJson["yesValues"][0]
		new_card.yesIncome = cardJson["yesValues"][1]
		new_card.yesSocial = cardJson["yesValues"][2]
		new_card.yesHealth = cardJson["yesValues"][3]
		
		new_card.noEducation = cardJson["noValues"][0]
		new_card.noIncome = cardJson["noValues"][1]
		new_card.noSocial = cardJson["noValues"][2]
		new_card.noHealth = cardJson["noValues"][3]
	
		cards.append(new_card)

func nex_card() -> CardResource:
	currentCard = cards.pop_front()
	return currentCard
