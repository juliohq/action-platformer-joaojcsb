extends BaseState


func on_enter() -> void:
	animator.play(&"IDLE")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		if Input.is_action_just_pressed("melee"):
			change_state("Melee")
			return
		elif Input.is_action_just_pressed("heal"):
			if root.heal():
				return
		elif Input.is_action_just_pressed("attack_1"):
			root.try_shoot(Globals.Attack.A)
			return
		elif Input.is_action_just_pressed("attack_2"):
			root.try_shoot(Globals.Attack.B)
			return
		
		# Movement
		root.direction = Input.get_axis(&"left", &"right")
		
		if root.direction:
			change_state("Run")
	else:
		change_state("Fall")
	
	root.jump()
