extends Control
class_name Pause


## A sound to be played when paused.
@export var pause_sound: AudioStream
## A sound to be played when resumed.
@export var resume_sound: AudioStream
## The volume to play the sound.
@export_range(0.0, 2.0, 0.01) var sound_volume := 1.0
## The bus to play the sound.
@export var sound_bus := &"Sounds"
## The control to be focused when the game is paused.
@export var focus_control: Control

# The previous mouse mode.
var mouse_mode := Input.MOUSE_MODE_VISIBLE


func _ready() -> void:
	%Resume.pressed.connect(_resume)
	%Options.pressed.connect(_options)
	%MainMenu.pressed.connect(_main_menu)
	%Quit.pressed.connect(_quit)
	
	AudioManager.play(pause_sound, sound_volume, sound_bus)
	
	mouse_mode = Input.mouse_mode
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_handle_pause(true)
	
	if is_instance_valid(focus_control):
		focus_control.grab_focus()
	
	Events.game_paused.emit()


func _exit_tree() -> void:
	AudioManager.play(resume_sound, sound_volume, sound_bus)
	Input.mouse_mode = mouse_mode
	_handle_pause(false)
	Events.game_resumed.emit()


## Handles the pause logic. Override to provide custom behavior.
func _handle_pause(paused: bool) -> void:
	get_tree().paused = paused


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		queue_free()


## Handles the resume logic. Override to provide custom behavior.
func _resume() -> void:
	queue_free()


## Handles the game options logic. Override to provide custom behavior.
func _options() -> void:
	var options := preload("res://ui/options.tscn").instantiate()
	%Margin.hide()
	options.tree_exited.connect(%Margin.show)
	options.tree_exited.connect(%Options.grab_focus)
	add_child(options)


## Handles the main menu logic. Override to provide custom behavior.
func _main_menu() -> void:
	get_tree().change_scene_to_packed(load("res://ui/main_menu.tscn"))


## Handles the game quit logic. Override to provide custom behavior.
func _quit() -> void:
	add_child(preload("res://ui/quit_confirmation.tscn").instantiate())
