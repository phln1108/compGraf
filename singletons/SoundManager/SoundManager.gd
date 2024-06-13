extends Node

var position: float = 0
@onready var audio: AudioStreamPlayer = $Audio

var button: AudioStream = preload("res://sounds/clickbutton.wav")

func _ready():
	audio.volume_db = linear_to_db(0.5)
	$AudioStreamPlayer.volume_db = linear_to_db(0.5)

func play(sound: AudioStream = button) -> void:
	audio.stop()
	audio.stream = sound
	audio.play(0)
	position = 0

func pause() -> void:
	if audio.has_stream_playback():
		position = audio.get_playback_position()
		audio.stop()

func stop() -> void:
	audio.stop()
	audio.stream = null
	
func unpause() -> void:
	if audio.has_stream_playback() and not position == 0:
		audio.play(position)
		position = 0
		
func setVolume(value: float) -> void:
	audio.volume_db = linear_to_db(value)

func setVolumeMusic(value: float) -> void:
	$AudioStreamPlayer.volume_db = linear_to_db(value)

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
