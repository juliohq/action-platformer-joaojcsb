extends BaseState


const ENEMY_LAYER := 4

@export var idle: BaseState
@export var player_detector: Area2D
@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0


func on_enter() -> void:
	animator.play("CAMOUFLAGED")
	root.set_collision_layer_value(ENEMY_LAYER, false)


func on_exit() -> void:
	root.set_collision_layer_value(ENEMY_LAYER, true)


func on_physics_process(_delta: float) -> void:
	if player_detector.has_overlapping_bodies():
		AudioManager.play(audio, audio_volume, &"Sounds")
		state_machine.current_state = idle
