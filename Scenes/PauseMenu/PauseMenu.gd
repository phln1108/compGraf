extends Control

func Pauseshow():
	get_tree().paused = true
	self.visible = true
	
func Pausehide():
	get_tree().paused = false
	self.visible = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
