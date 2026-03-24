extends Control


## A sound to be played once.
@export var sound: AudioStream
## The volume to play the sound.
@export_range(0.0, 2.0, 0.01) var sound_volume := 1.0
## The bus to play the sound.
@export var sound_bus := &"Sounds"
## The control to be focused when the game is paused.
@export var focus_control: Control


func _ready() -> void:
	_handle_pause(true)
	AudioManager.play(sound, sound_volume, sound_bus)
	
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


func _exit_tree() -> void:
	_handle_pause(false)


## Handles the pause logic. Override to provide custom behavior.
func _handle_pause(paused: bool) -> void:
	get_tree().paused = paused


## Handles the play again logic. Override to provide custom behavior.
func _play_again() -> void:
	push_warning("The play again logic might be partially implemented")
	get_tree().reload_current_scene()


## Handles the main menu logic. Override to provide custom behavior.
func _main_menu() -> void:
	get_tree().change_scene_to_packed(load("res://ui/main_menu.tscn"))


## Handles the game quit logic. Override to provide custom behavior.
func _quit() -> void:
	get_tree().quit()
