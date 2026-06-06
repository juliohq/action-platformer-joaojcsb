extends Node


@export var hover_audio: AudioStream
@export var press_audio: AudioStream

@onready var parent: Button = get_parent()


func _ready() -> void:
	parent.mouse_entered.connect(_mouse_entered)
	parent.pressed.connect(_pressed)


func _mouse_entered() -> void:
	AudioManager.play(hover_audio, 1.0, &"Sounds")


func _pressed() -> void:
	AudioManager.play(press_audio, 1.0, &"Sounds")
