extends BaseState


const DIVE_SPEED := 2.66
const SWOOP_START := 1.0
const SWOOP_END := -1.0

@export var follow: BaseState
@export var pivot: Node2D
@export var hit_box: CollisionShape2D

var y := SWOOP_START


func on_enter() -> void:
	root.current_speed = root.charge_speed
	hit_box.disabled = false
	y = SWOOP_START


func on_physics_process(delta: float) -> void:
	animator.play("FLY_ENGAGE")
	
	# Flip sprite
	if root.direction.x > 0.0:
		pivot.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction.x < 0.0:
		pivot.scale.x = 1 if root.sprite_faces_left else -1
	
	# Goal
	var target: Node2D = root.fly_left
	var distance: float = target.global_position.x - root.global_position.x
	
	if absf(distance) > root.GOAL_DISTANCE:
		root.direction.x = signf(distance)
		y = move_toward(y, SWOOP_END, DIVE_SPEED * delta)
		root.direction.y = y
		root.direction = root.direction.normalized()
	else:
		state_machine.current_state = follow
