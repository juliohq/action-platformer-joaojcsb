extends BaseState


@export var next_state: BaseState
@export var pivot: Node2D
@export var audio: AudioStreamPlayer


func on_enter() -> void:
	animator.play("FLY_ENGAGE")
	root.current_speed = root.charge_speed


func on_physics_process(_delta: float) -> void:
	# Flip sprite
	if root.direction.x > 0.0:
		pivot.scale.x = -1 if root.sprite_faces_left else 1
	elif root.direction.x < 0.0:
		pivot.scale.x = 1 if root.sprite_faces_left else -1
	
	# Goal
	var target: Node2D = root.charge_left
	var distance: float = target.global_position.x - root.global_position.x
	
	if absf(distance) > root.GOAL_DISTANCE:
		root.direction.x = signf(distance)
	else:
		root.direction = Vector2()
		var animation := "ATTACK_B"
		
		if animator.assigned_animation == animation:
			if not animator.is_playing():
				state_machine.current_state = next_state
		else:
			animator.play(animation)
			audio.play()
