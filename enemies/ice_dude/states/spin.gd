extends BaseState


const BOUND_CHECK := 0.05
const RANDOM_SPINNING := 3.0

@export var sprite: Sprite2D
@export var flame: Sprite2D
@export var player_detector: Area2D
@export var surface_detector: Node2D
@export var audio: AudioStreamPlayer2D

# Fix bounds checks too often
var bound_check := 0.0
## Time until spin randomly.
var random_spinning := 0.0


func on_enter() -> void:
	animator.play("SPINNING")
	flame.show()
	random_spinning = RANDOM_SPINNING
	root.direction = signf(randf() - 0.5)
	audio.play()


func on_exit() -> void:
	flame.hide()


func on_physics_process(delta: float) -> void:
	# Flip sprite
	if root.direction > 0.0:
		sprite.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction < 0.0:
		sprite.scale.x = 1 if root.sprite_faces_left else -1
	
	if bound_check > 0.0:
		bound_check -= delta
	else:
		bound_check = BOUND_CHECK
		
		if surface_detector.bound_reached():
			root.direction *= -1
		else:
			for player: Node2D in player_detector.get_overlapping_bodies():
				root.direction = signf(player.global_position.x - root.global_position.x)
				
				# Change to idle
				change_state("Idle")
				
				break
	
	# Random spinning
	if random_spinning > 0.0:
		random_spinning -= delta
	else:
		change_state("Idle")
