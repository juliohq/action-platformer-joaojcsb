extends BaseState


const TIME_LEFT := 1.0

@export var swoop_right: BaseState
@export var pivot: Node2D
@export var collision: CollisionShape2D
@export var hit: BaseState

var time_left := 0.0


func on_enter() -> void:
	root.current_speed = root.movement_speed
	collision.disabled = true
	root.gravity_enabled = false
	
	if state_machine._previous_state != hit:
		time_left = TIME_LEFT


func on_physics_process(delta: float) -> void:
	animator.play("FLY_B")
	
	# Flip sprite
	if root.direction.x > 0.0:
		pivot.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction.x < 0.0:
		pivot.scale.x = 1 if root.sprite_faces_left else -1
	
	# Goal
	var target: Node2D = root.fly_left
	var distance: float = target.global_position.distance_to(root.global_position)
	var direction: Vector2 = root.global_position.direction_to(target.global_position)
	
	if distance > root.GOAL_DISTANCE:
		root.direction = direction
	else:
		root.direction = Vector2()
		
		if time_left > 0.0:
			time_left -= delta
		else:
			state_machine.current_state = swoop_right
