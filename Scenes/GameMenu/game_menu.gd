extends Control
class_name GameMenu

func _ready() -> void:
	PauseMenu.pause.connect(on_unpause)

func on_unpause() -> void:
	$ColorRect2.visible = false	

func _on_play_button_pressed() -> void:
	SoundManager.play()
	SignalBus.emit_signal("restartGame")
	get_tree().change_scene_to_file("res://Scenes/Map/map.tscn")

func _on_config_button_pressed() -> void:
	$ColorRect2.visible = true
	PauseMenu.Pauseshow(self)
	
func _on_exit_button_pressed() -> void:
	SoundManager.play()
	get_tree().quit()


func _on_help_button_pressed():
	SoundManager.play()
	get_tree().change_scene_to_file("res://Scenes/HelpMenu/helpMenu.tscn")
	
