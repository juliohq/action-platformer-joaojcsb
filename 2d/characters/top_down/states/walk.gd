extends BaseState


func on_physics_process(_delta: float) -> void:
	root.direction = Input.get_vector(&"left", &"right", &"up", &"down")
	root.play_animation(&"WALK_LEFT", &"WALK_RIGHT", &"WALK_UP", &"WALK_DOWN")
	
	if not root.direction:
		change_state("Idle")
