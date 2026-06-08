extends Control


const PROLOGUE := preload("res://ui/prologue.tscn")

## The parent node to spawn dynamic nodes.
@export var root: Node
## A sound to be played once.
@export var sound: AudioStream
## The volume to play the sound.
@export_range(0.0, 2.0, 0.01) var sound_volume := 1.0
## The bus to play the sound.
@export var sound_bus := &"Sounds"
## The control to be focused.
@export var focus_control: Control


func _ready() -> void:
	%NewGame.pressed.connect(_new_game)
	%LoadGame.pressed.connect(_load_game)
	%Options.pressed.connect(_options)
	%Quit.pressed.connect(_quit)
	
	AudioManager.play(sound, sound_volume, sound_bus)
	
	%Version.text = ProjectSettings.get_setting_with_override(&"application/config/version")
	
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


## Handles the logic when the new game button is pressed. Override to provide custom behavior.
func _new_game() -> void:
	get_tree().change_scene_to_packed(PROLOGUE)


## Handles the logic when the load game button is pressed. Override to provide custom behavior.
func _load_game() -> void:
	Globals.load_game()


## Handles the logic when the options button is pressed. Override to provide custom behavior.
func _options() -> void:
	%Margin.hide()
	var options := preload("res://ui/options.tscn").instantiate()
	options.tree_exited.connect(%Margin.show)
	options.tree_exited.connect(%Options.grab_focus)
	root.add_child(options)


## Handles the logic when the quit button is pressed. Override to provide custom behavior.
func _quit() -> void:
	root.add_child(preload("res://ui/quit_confirmation.tscn").instantiate())
