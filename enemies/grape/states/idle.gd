extends BaseState


@export var sprite: Sprite2D
@export var player_detector: Area2D


func on_enter() -> void:
	animator.play("IDLE")


func on_physics_process(_delta: float) -> void:
	for player: Node2D in player_detector.get_overlapping_bodies():
		if root.position.x > player.position.x:
			sprite.flip_h = root.sprite_faces_left
		elif root.position.x < player.position.x:
			sprite.flip_h = not root.sprite_faces_left
		
		break
