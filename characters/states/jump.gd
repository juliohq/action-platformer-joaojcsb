extends BaseState


func on_enter() -> void:
	animator.play(&"JUMP")


func on_physics_process(delta: float) -> void:
	root.direction = Input.get_axis(&"left", &"right")
	
	# Shoot
	if root.handle_attack(delta):
		return
	
	if root.is_on_floor():
		change_state("Idle")
	elif root.velocity.y > 0.0:
		change_state("Fall")
	
	root.jump()
