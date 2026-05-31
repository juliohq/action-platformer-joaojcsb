extends BaseState


const TIME_LEFT := 3.0

@export var dive: BaseState
@export var pivot: Node2D
@export var hit_box: CollisionShape2D
@export var hit: BaseState

var time_left := 0.0


func on_enter() -> void:
	root.current_speed = root.movement_speed
	hit_box.disabled = true
	
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
	var target: Node2D = root.follow_height
	var target_position: Vector2 = Vector2(Globals.player.global_position.x, target.global_position.y)
	var distance: float = target_position.distance_to(root.global_position)
	var direction: Vector2 = root.global_position.direction_to(target_position)
	root.direction = direction
	
	if distance <= root.GOAL_DISTANCE:
		root.direction = Vector2()
	
	if time_left > 0.0:
		time_left -= delta
	else:
		state_machine.current_state = dive
