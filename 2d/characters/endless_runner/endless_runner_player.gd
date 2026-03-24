extends EndlessRunnerCharacter2D
class_name EndlessRunnerPlayer2D


func _unhandled_input(event: InputEvent) -> void:
	# Jump logic
	if event.is_action_pressed(&"jump") and is_on_floor():
		get_viewport().set_input_as_handled()
		jump()
	# Variable jump height logic
	elif event.is_action_released(&"jump") and velocity.y < 0.0:
		get_viewport().set_input_as_handled()
		fall()
