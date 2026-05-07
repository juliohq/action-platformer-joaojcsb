extends BaseState


func on_enter() -> void:
	AudioManager.play(preload("res://assets/audio/player_melee.wav"), 1.0, &"Sounds")
	
	animator.play(&"MELEE")
	await animator.animation_finished
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
