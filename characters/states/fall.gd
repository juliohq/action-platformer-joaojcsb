extends BaseState


func on_enter() -> void:
	animator.play(&"FALL")


func on_physics_process(_delta: float) -> void:
	root.direction = Input.get_axis(&"left", &"right")
	
	# Shoot
	if Input.is_action_just_pressed("attack_1"):
		root.try_shoot(Globals.Attack.A)
		return
	elif Input.is_action_just_pressed("attack_2"):
		root.try_shoot(Globals.Attack.B)
		return
	
	if root.is_on_floor():
		change_state("Idle")
