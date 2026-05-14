extends Node


enum Bus {
	AUDIO,
	MUSIC,
}

@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0
@export var bus := Bus.AUDIO


func _ready() -> void:
	var bus_name := "Sounds" if bus == Bus.AUDIO else "Music"
	AudioManager.play(audio, audio_volume, bus_name)
