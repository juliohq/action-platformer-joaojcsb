extends BaseState


func on_enter() -> void:
	animator.play(&"SHOOT")
	await animator.animation_finished
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	if root.is_on_floor():
		root.direction = 0.0
