extends BaseState


const ENEMY_LAYER := 4

@export var idle: BaseState
@export var player_detector: Area2D


func on_enter() -> void:
	animator.play("CAMOUFLAGED")
	root.set_collision_layer_value(ENEMY_LAYER, false)


func on_exit() -> void:
	root.set_collision_layer_value(ENEMY_LAYER, true)


func on_physics_process(_delta: float) -> void:
	if player_detector.has_overlapping_bodies():
		state_machine.current_state = idle
		change_state("Idle")
