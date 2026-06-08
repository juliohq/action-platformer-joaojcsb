extends BaseState


const TIME_LEFT := 3.0
const FLY_THRESHOLD := 0

@export var fly_left: BaseState
@export var fly_right: BaseState
@export var pivot: Node2D
@export var collision: CollisionShape2D
@export var hit: BaseState

var time_left := 0.0


func on_enter() -> void:
	root.current_speed = root.charge_speed
	
	animator.play("DIVE")
	
	if time_left > 0.0:
		animator.seek(animator.current_animation_length)
	
	if state_machine._previous_state != hit:
		time_left = TIME_LEFT


func on_physics_process(delta: float) -> void:
	# Flip sprite
	if root.direction.x > 0.0:
		pivot.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction.x < 0.0:
		pivot.scale.x = 1 if root.sprite_faces_left else -1
	
	# Goal
	var target: Node2D = root.dive_height
	var target_position: Vector2 = Vector2(root.global_position.x, target.global_position.y)
	var distance: float = target_position.distance_to(root.global_position)
	
	if distance > root.GOAL_DISTANCE:
		root.direction = Vector2.DOWN
	else:
		root.direction = Vector2()
		collision.disabled = false
		
		if time_left > 0.0:
			time_left -= delta
		elif Globals.player.global_position.x < FLY_THRESHOLD:
			state_machine.current_state = fly_left
		else:
			state_machine.current_state = fly_right
