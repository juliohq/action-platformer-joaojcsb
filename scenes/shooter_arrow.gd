extends Node2D


@export var scene: PackedScene


func shoot() -> void:
	var bullet := scene.instantiate()
	bullet.direction = Vector2.from_angle(rotation)
	bullet.global_position = global_position
	Events.bullet.emit(bullet)
