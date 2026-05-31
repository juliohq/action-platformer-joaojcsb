extends BaseState


@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0


func on_enter() -> void:
	AudioManager.play(audio, audio_volume, &"Sounds")
	animator.play("HIT")
	await animator.animation_finished
	state_machine.previous_state()


func on_physics_process(_delta: float) -> void:
	root.direction = Vector2()
