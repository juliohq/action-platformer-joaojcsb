extends BaseState


@export var walk: BaseState
@export var sprite: Sprite2D
@export var player_detector: Area2D


func on_enter() -> void:
	animator.play("IDLE")
	state_machine.current_state = walk


func on_physics_process(_delta: float) -> void:
	for player: Node2D in player_detector.get_overlapping_bodies():
		if root.position.x > player.position.x:
			sprite.scale.x = -1 if root.sprite_faces_left else 1
		elif root.position.x < player.position.x:
			sprite.scale.x = 1 if root.sprite_faces_left else -1
		
		break
