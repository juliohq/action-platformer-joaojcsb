extends BaseState


const HEAL := preload("res://assets/audio/heal.wav")


func on_enter() -> void:
	animator.play(&"HEAL")
	AudioManager.play(HEAL, 1.0, &"Sounds")
	await animator.animation_finished
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
