extends BaseState


func on_enter() -> void:
	animator.play(&"FALL")


func on_physics_process(_delta: float) -> void:
	root.direction = Input.get_axis(&"left", &"right")
	
	if root.is_on_floor():
		change_state("Idle")
