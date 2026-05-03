extends BaseState


@export var walk: BaseState
@export var sprite: Sprite2D
@export var player_detector: Area2D
@export var shoot: Node2D


func on_enter() -> void:
	animator.play("ATTACK")
	shoot.shoot()
	await animator.animation_finished
	change_state("Idle")
