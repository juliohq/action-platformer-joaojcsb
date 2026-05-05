extends BaseState


@export var sprite: Sprite2D


func on_enter() -> void:
	animator.play(&"DEATH")
	await animator.animation_finished
	Events.game_over.emit()


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
	# Bypass invincibility
	sprite.modulate.a = 1.0
