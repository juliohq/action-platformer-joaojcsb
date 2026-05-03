extends BaseState


const JUMP_HEIGHT := 256
const JUMP_INTERVAL := 0.5

@export var sprite: Sprite2D
@export var player_detector: Area2D

## Time left until jump again.
var time_left := 0.0


func on_enter() -> void:
	animator.play("IDLE")


func on_physics_process(delta: float) -> void:
	# Flip sprite
	for player: Node2D in player_detector.get_overlapping_bodies():
		if root.position.x > player.position.x:
			sprite.flip_h = not root.sprite_faces_left
		elif root.position.x < player.position.x:
			sprite.flip_h = root.sprite_faces_left
		
		break
	
	# Jump
	jump(delta)


func jump(delta: float) -> void:
	if root.is_on_floor():
		if time_left > 0.0:
			time_left -= delta
		else:
			time_left = JUMP_INTERVAL
			root.velocity.y = -JUMP_HEIGHT
			root.move_and_slide()
