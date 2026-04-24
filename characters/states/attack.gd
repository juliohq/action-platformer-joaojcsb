extends BaseState


func on_enter() -> void:
	if true:
		animator.play(&"SHOOT")
	else:
		animator.play(&"MELEE")
	
	await animator.animation_finished
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
