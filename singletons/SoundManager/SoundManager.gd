extends Node

var position: float = 0
@onready var audio: AudioStreamPlayer = $Audio


func play(sound: AudioStream) -> void:
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
		
func setVolume(value: float):
	audio.volume_db = linear_to_db(value)
