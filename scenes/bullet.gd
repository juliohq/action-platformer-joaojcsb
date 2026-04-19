extends Area2D


## How fast the bullet will move.
@export_range(1, 128, 1, "or_greater", "suffix:px/s") var speed := 128
@export_category("Nodes")
@export var sprite: Sprite2D

## The current direction of the bullet.
var direction := Vector2()


func _ready() -> void:
	# Rotate the sprite
	sprite.rotation = direction.angle()


func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
