extends BaseState


func on_enter() -> void:
	animator.play(&"FALL")


func on_physics_process(delta: float) -> void:
	root.direction = Input.get_axis(&"left", &"right")
	
	# Shoot
	if root.handle_attack(delta):
		return
	
	if root.is_on_floor():
		change_state("Idle")
	
	root.jump()
