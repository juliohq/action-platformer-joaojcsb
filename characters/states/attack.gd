extends BaseState


func on_enter() -> void:
	animator.play(&"ATTACK")
	await animator.animation_finished
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
