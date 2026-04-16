extends BaseState


@export var idle: BaseState
@export var player_detector: Area2D


func on_enter() -> void:
	animator.play("CAMOUFLAGED")


func on_physics_process(_delta: float) -> void:
	if player_detector.has_overlapping_bodies():
		state_machine.current_state = idle
		change_state("Idle")
