extends BaseState


func on_enter() -> void:
	animator.play(&"WALK")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		root.direction = Input.get_axis(&"left", &"right")
		
		if not root.direction:
			change_state("Idle")
	else:
		change_state("Fall")
