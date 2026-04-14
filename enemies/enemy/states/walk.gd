extends BaseState


@export var surface_detector: Node2D


func on_enter() -> void:
	root.direction = signf(randf() - 0.5)


func on_physics_process(_delta: float) -> void:
	if surface_detector.bound_reached():
		root.direction *= -1
