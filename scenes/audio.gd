extends Node


@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0


func _ready() -> void:
	AudioManager.play(audio, audio_volume, "Sounds")
