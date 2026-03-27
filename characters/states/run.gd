extends BaseState


func on_enter() -> void:
	animator.play(&"RUN")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		root.direction = Input.get_axis(&"left", &"right")
		
		if not root.direction:
			change_state("Idle")
	else:
		root.coyote_buffer = root.coyote_buffering
		change_state("Fall")
