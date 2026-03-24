extends BaseState


func on_physics_process(_delta: float) -> void:
	root.direction = Input.get_vector(&"left", &"right", &"up", &"down")
	root.play_animation(&"IDLE_LEFT", &"IDLE_RIGHT", &"IDLE_UP", &"IDLE_DOWN")
	
	if root.direction:
		change_state("Walk")
