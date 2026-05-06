extends BaseState


const JUMP_HEIGHT := 256
const JUMP_INTERVAL := 0.5

@export var sprite: Sprite2D
@export var player_detector: Area2D

## Time left until jump again.
var jump_timer := 0.0


func on_enter() -> void:
	animator.play("IDLE")


func on_physics_process(delta: float) -> void:
	# Flip sprite
	for player: Node2D in player_detector.get_overlapping_bodies():
		if root.position.x > player.position.x:
			sprite.scale.x = 1 if root.sprite_faces_left else -1
		elif root.position.x < player.position.x:
			sprite.scale.x = -1 if root.sprite_faces_left else 1
		
		break
	
	# Jump
	jump(delta)


func jump(delta: float) -> void:
	if root.is_on_floor():
		if jump_timer > 0.0:
			jump_timer -= delta
		else:
			jump_timer = JUMP_INTERVAL
			root.velocity.y = -JUMP_HEIGHT
			root.move_and_slide()
