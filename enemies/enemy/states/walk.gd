extends BaseState


@export var sprite: Sprite2D
@export var surface_detector: Node2D


func on_enter() -> void:
	animator.play("RUN")
	root.direction = signf(randf() - 0.5)


func on_physics_process(_delta: float) -> void:
	if surface_detector.bound_reached():
		root.direction *= -1
	
	# Flip sprite
	if root.direction > 0.0:
		sprite.flip_h = false
	elif root.direction < 0.0:
		sprite.flip_h = true
