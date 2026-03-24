extends Control
class_name Inventory


func _ready() -> void:
	_handle_pause(true)
	Events.game_paused.emit()


func _exit_tree() -> void:
	_handle_pause(false)


## Handles the pause logic. Override to provide custom behavior.
func _handle_pause(paused: bool) -> void:
	get_tree().paused = paused


func _input(event: InputEvent) -> void:
	if (event.is_action_pressed(&"inventory")
			or event.is_action_pressed(&"ui_cancel")):
		get_viewport().set_input_as_handled()
		queue_free()


## Handles the close logic. Override to provide custom behavior.
func _close() -> void:
	queue_free()
