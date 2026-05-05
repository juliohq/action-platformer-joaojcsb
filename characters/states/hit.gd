extends BaseState


@export var sprite: Sprite2D


func on_enter() -> void:
	var effect := preload("res://scenes/player_hit.tscn").instantiate()
	effect.scale.x = sprite.scale.x
	effect.global_position = root.global_position
	Events.player_hit.emit(effect)
	
	# Play animation
	animator.play(&"HIT")
	await animator.animation_finished
	
	change_state("Idle")


func on_physics_process(_delta: float) -> void:
	root.direction = 0.0
