extends Node2D

signal end

func boom():
	$AnimatedSprite2D.play("explosion")

func _on_animated_sprite_2d_animation_finished():
	end.emit()
	queue_free()
