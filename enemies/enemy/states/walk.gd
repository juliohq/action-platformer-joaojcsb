extends BaseState


const BOUND_CHECK := 0.05

@export var sprite: Sprite2D
@export var surface_detector: Node2D

# Fix bounds checks too often
var time_left := 0.0


func on_enter() -> void:
	animator.play("WALK")
	root.direction = signf(randf() - 0.5)


func on_physics_process(delta: float) -> void:
	if time_left > 0.0:
		time_left -= delta
	else:
		time_left += BOUND_CHECK
		
		if surface_detector.bound_reached():
			root.direction *= -1
	
	# Flip sprite
	if root.direction > 0.0:
		sprite.flip_h = root.sprite_faces_left
	elif root.direction < 0.0:
		sprite.flip_h = not root.sprite_faces_left
