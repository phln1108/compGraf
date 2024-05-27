extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map/map.tscn")

func _on_config_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()
