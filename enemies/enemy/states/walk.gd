extends BaseState


const BOUND_CHECK := 0.05
const EDGE_TURN := 0.5
const PLAYER_DISTANCE := 50

@export var sprite: Sprite2D
@export var player_detector: Area2D
@export var surface_detector: Node2D

# Fix bounds checks too often
var bound_check := 0.0
var edge_turn := 0.0


func on_enter() -> void:
	animator.play("WALK")
	root.direction = signf(randf() - 0.5)


func on_physics_process(delta: float) -> void:
	# Flip sprite
	if root.direction > 0.0:
		sprite.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction < 0.0:
		sprite.scale.x = 1 if root.sprite_faces_left else -1
	
	if edge_turn > 0.0:
		edge_turn -= delta
	
	if bound_check > 0.0:
		bound_check -= delta
	else:
		bound_check = BOUND_CHECK
		
		if surface_detector.bound_reached():
			root.direction *= -1
			edge_turn = EDGE_TURN
		elif edge_turn <= 0.0:
			follow_player()


func follow_player() -> void:
	for player: Node2D in player_detector.get_overlapping_bodies():
		if absf(player.global_position.x - root.global_position.x) >= PLAYER_DISTANCE:
			root.direction = signf(player.global_position.x - root.global_position.x)
		
		return
