extends BaseState


@export var walk: BaseState
@export var sprite: Sprite2D
@export var player_detector: Area2D
@export var shoot: Node2D


func on_enter() -> void:
	animator.play("IDLE")


func on_physics_process(_delta: float) -> void:
	for player: Node2D in player_detector.get_overlapping_bodies():
		# Flip sprite
		if root.position.x > player.position.x:
			sprite.scale.x = 1 if root.sprite_faces_left else -1
		elif root.position.x < player.position.x:
			sprite.scale.x = -1 if root.sprite_faces_left else 1
		
		# Force stop
		root.direction = 0.0
		
		# Attack
		if player.freeze_time <= 0.0 and shoot.can_shoot():
			change_state("Attack")
		
		return
	
	# Walk if the player is not in the range
	state_machine.current_state = walk
