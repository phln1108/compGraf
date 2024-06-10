extends Node

var cards: Array[JsonCard]

var currentCard: JsonCard

func _ready() -> void:
	var dataFile = FileAccess.open("res://cards.json",FileAccess.READ)
	var parsed = JSON.parse_string(dataFile.get_as_text())
	
	var cardsFolder = DirAccess.open("res://assets/cardIcons/")
	cardsFolder.list_dir_begin()
	var files = []
	var file_name = cardsFolder.get_next()
	while file_name != "":
		if !cardsFolder.current_is_dir():
			if file_name.ends_with(".png") or file_name.ends_with(".jpg") or file_name.ends_with(".jpeg") or file_name.ends_with(".webp"):
				files.append("res://assets/cardIcons/" + file_name)
		file_name = cardsFolder.get_next()
		
	for cardJson in parsed:
		var new_card: JsonCard = JsonCard.new()
		
		var random_index = randi() % files.size()
		new_card.sprite = load(files[random_index])
		new_card.text = cardJson["text"]
		new_card.yesMsg = cardJson["yesMsg"]
		new_card.noMsg = cardJson["noMsg"]
		new_card.yesValues = []
		new_card.noValues= []
		for i in range(4):
			new_card.yesValues.append(cardJson["yesValues"][i])
			new_card.noValues.append(cardJson["noValues"][i])
		
		cards.append(new_card)

func nex_card() -> JsonCard:
	currentCard = cards.pop_front()
	return currentCard
