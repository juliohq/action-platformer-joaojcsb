extends BaseState


func on_enter() -> void:
	animator.play(&"IDLE")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		root.direction = Input.get_axis(&"left", &"right")
		
		if root.direction:
			change_state("Walk")
	else:
		change_state("Fall")
