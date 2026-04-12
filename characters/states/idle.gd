extends BaseState


func on_enter() -> void:
	animator.play(&"IDLE")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		if Input.is_action_just_pressed("attack"):
			change_state("Attack")
			return
		
		# Movement
		root.direction = Input.get_axis(&"left", &"right")
		
		if root.direction:
			change_state("Run")
	else:
		change_state("Fall")
