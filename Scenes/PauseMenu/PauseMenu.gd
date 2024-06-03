extends Control

func Pauseshow() -> void:
	get_tree().paused = true
	self.visible = true
	
func Pausehide() -> void:
	get_tree().paused = false
	self.visible = false

