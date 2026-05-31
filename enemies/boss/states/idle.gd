extends BaseState


@export var charge_left: BaseState
@export var charge_right: BaseState
@export var flip := false
@export var player_detector: Area2D
@export var pivot: Node2D


func on_enter() -> void:
	animator.play("IDLE")
	
	if flip:
		pivot.scale.x = 1 if root.sprite_faces_left and flip else -1
	else:
		pivot.scale.x = -1 if root.sprite_faces_left else 1


func on_physics_process(_delta: float) -> void:
	for player: Node2D in player_detector.get_overlapping_bodies():
		root.player = player
		root.join_fight()
		
		if player.global_position.x < root.global_position.x:
			state_machine.current_state = charge_left
		else:
			state_machine.current_state = charge_right
		
		return
