extends BaseState


const TIME_LEFT := 0.5

@export var charge_right: BaseState
@export var fly_right: BaseState
@export var pivot: Node2D
@export var hit: BaseState

var time_left := 0.0


func on_enter() -> void:
	root.current_speed = root.movement_speed
	
	if state_machine._previous_state != hit:
		time_left = TIME_LEFT


func on_physics_process(delta: float) -> void:
	# Flip sprite
	if root.direction.x > 0.0:
		pivot.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction.x < 0.0:
		pivot.scale.x = 1 if root.sprite_faces_left else -1
	
	# Goal
	var target: Node2D = root.swing_left
	var distance: float = target.global_position.x - root.global_position.x
	
	if absf(distance) > root.GOAL_DISTANCE:
		animator.play("WALK")
		root.direction.x = signf(distance)
	else:
		animator.play("IDLE")
		root.direction = Vector2()
		
		if time_left > 0.0:
			time_left -= delta
		elif root.health <= root.ATTACK_B_HEALTH:
			Events.eagle_spawner_started.emit()
			state_machine.current_state = fly_right
		else:
			state_machine.current_state = charge_right
