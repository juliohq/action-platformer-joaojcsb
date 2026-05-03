extends BaseState


const BOUND_CHECK := 0.05

@export var sprite: Sprite2D
@export var player_detector: Area2D
@export var surface_detector: Node2D
@export var shoot: Node2D

# Fix bounds checks too often
var time_left := 0.0
## Time until spin randomly.
var random_spinning := 0.0


func on_enter() -> void:
	animator.play("WALK")
	root.direction = signf(randf() - 0.5)


func on_physics_process(delta: float) -> void:
	# Flip sprite
	if root.direction > 0.0:
		sprite.flip_h = root.sprite_faces_left
	elif root.direction < 0.0:
		sprite.flip_h = not root.sprite_faces_left
	
	if time_left > 0.0:
		time_left -= delta
	else:
		time_left += BOUND_CHECK
		
		if surface_detector.bound_reached():
			root.direction *= -1
		else:
			for player: Node2D in player_detector.get_overlapping_bodies():
				root.direction = signf(player.global_position.x - root.global_position.x)
				
				if player.freeze_time <= 0.0:
					shoot.shoot()
				
				# Change to idle
				change_state("Idle")
				
				break
	
	# Random spinning
	if random_spinning > 0.0:
		random_spinning -= delta
	else:
		random_spinning += randf_range(1.0, 4.0)
		root.direction *= -1
