extends BaseState


func on_enter() -> void:
	animator.play(&"RUN")


func on_physics_process(delta: float) -> void:
	if root.is_on_floor():
		if Input.is_action_just_pressed("melee"):
			change_state("Melee")
			return
		elif Input.is_action_just_pressed("heal"):
			if root.heal():
				change_state("Heal")
				return
		elif root.handle_attack(delta):
			return
		
		# Movement
		root.direction = Input.get_axis(&"left", &"right")
		
		if not root.direction:
			change_state("Idle")
	else:
		root.coyote_buffer = root.coyote_buffering
		change_state("Fall")
	
	root.jump()
