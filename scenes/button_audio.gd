extends Node


## Play audio on focus events.
@export var focus_enabled := true
## Play audio on mouse events.
@export var mouse_enabled := true
## Play audio on pressed.
@export var press_enabled := true
@export var hover_audio: AudioStream
@export var press_audio: AudioStream

@onready var parent: Control = get_parent()


func _ready() -> void:
	if focus_enabled:
		parent.focus_entered.connect(_mouse_entered)
	
	if mouse_enabled:
		parent.mouse_entered.connect(_mouse_entered)
	
	if press_enabled:
		parent.pressed.connect(_pressed)


func _mouse_entered() -> void:
	AudioManager.play(hover_audio, 1.0, &"Sounds")


func _pressed() -> void:
	AudioManager.play(press_audio, 1.0, &"Sounds")
