extends Control

signal pause
signal unpause

var beep: AudioStream = preload("res://sounds/volumeTest.mp3")

var object: Control = null

func Pauseshow(caller: Control) -> void:
	get_tree().paused = true
	self.visible = true
	pause.emit()
	$Quit.visible = not caller is GameMenu
	caller.visible = false
	object = caller
	
func Pausehide() -> void:
	get_tree().paused = false
	self.visible = false
	unpause.emit()
	object.visible = true

func _on_quit_pressed():
	self.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/GameMenu/game_menu.tscn")

func _on_music_value_changed(value: float) -> void:
	SoundManager.setVolume(value)
	SoundManager.play(beep)
	
