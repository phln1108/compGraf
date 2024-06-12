extends Node


var cards: Array[JsonCard]

var currentCard: JsonCard

var to_remove: String = ""

func _ready() -> void:
	SignalBus.connect("gameEnd",onRestart)
	SignalBus.connect("cardSideChosed",on_card_chose_side)
	addToDeck("res://cards.json")
	

func nex_card() -> JsonCard:
	print(to_remove)
	if to_remove != "":
		var i = 0
		while  i != len(cards):
			print(cards[i].type)
			if cards[i].type == to_remove:
				print("a")
				cards.pop_at(i)			
			else:
				i+=1
		addToDeck("res://"+ to_remove +".json")
		to_remove = ""
	print(cards.size())
	if cards.size() == 0:
		SignalBus.emit_signal("gameEnd",-1,false)
		return
	var chosed: int = randi() % cards.size() 
	currentCard = cards.pop_at(chosed)
	return currentCard
	
func on_card_chose_side(sideChosed: Card.TextLabel ,values: Array[float], type: String) -> void:
	print(sideChosed,type)
	if type == "Entrevista" and sideChosed == Card.TextLabel.YES:
		to_remove = "Entrevista"
		
func addToDeck(path:String) -> void:
	
	var dataFile = FileAccess.open(path,FileAccess.READ)
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
		
		var random_index: int = randi() % files.size()
		new_card.sprite = load("res://assets/cardIcons/"+ cardJson["type"] +".png")
		new_card.type = cardJson["type"]
		new_card.text = cardJson["text"]
		new_card.yesMsg = cardJson["yesMsg"]
		new_card.noMsg = cardJson["noMsg"]
		new_card.yesValues = []
		new_card.noValues= []
		for i in range(4):
			new_card.yesValues.append(cardJson["yesValues"][i])
			new_card.noValues.append(cardJson["noValues"][i])
		
		cards.append(new_card)

func onRestart(bar: int, top: bool) -> void:
	cards = []
	addToDeck("res://cards.json")
