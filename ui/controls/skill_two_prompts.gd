extends Control


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _input(event: InputEvent) -> void:
	if ((event is InputEventKey and event.is_pressed()
			and event.physical_keycode == KEY_Q)
			or (event is InputEventJoypadButton and event.is_pressed()
			and event.button_index == JOY_BUTTON_A)):
		get_viewport().set_input_as_handled()
		queue_free()
