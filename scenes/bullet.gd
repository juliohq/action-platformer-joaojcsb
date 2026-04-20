extends Node2D


## How fast the bullet will move.
@export_range(1, 128, 1, "or_greater", "suffix:px/s") var speed := 128
## At which distance this bullet will vanish.
@export_range(1, 1_500, 1, "or_greater", "suffix:px")
var max_distance := 1000.0
@export_category("Nodes")
@export var sprite: Sprite2D
@export var hit_box: Area2D

## The current direction of the bullet.
var direction := Vector2()
## The distance left to vanish.
var distance_left := max_distance


func _ready() -> void:
	hit_box.hit.connect(_hit)
	
	# Rotate the sprite
	sprite.rotation = direction.angle()
	
	# Setup max distance
	distance_left = max_distance


func _physics_process(delta: float) -> void:
	var offset := speed * delta
	translate(direction * offset)
	
	# Vanish
	if distance_left > 0.0:
		distance_left -= offset
	else:
		queue_free()


func _hit(_body: Node2D) -> void:
	queue_free()
