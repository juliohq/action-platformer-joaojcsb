extends Control


const DURATION := 1.0

@export var audio: AudioStreamPlayer


func _ready() -> void:
	audio.finished.connect(_finished, CONNECT_ONE_SHOT)
	
	get_tree().paused = true


func _finished() -> void:
	Transition.start("res://ui/credits.tscn", DURATION, DURATION)
