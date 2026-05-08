extends BaseState


@export var idle: BaseState
@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0


func on_enter() -> void:
	AudioManager.play(audio, audio_volume, &"Sounds")
	animator.play("HIT")
	await animator.animation_finished
	state_machine.current_state = idle


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
