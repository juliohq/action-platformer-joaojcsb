extends CharacterBody2D


## The enemy default health.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 1
## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var speed := 64
@export_category("Nodes")
@export var sprite: Sprite2D

## The direction the eagles are flying to.
var direction := 0.0
## The current eagle health.
var health := max_health


func _ready() -> void:
	health = max_health
	add_to_group("eagles")


func _physics_process(_delta: float) -> void:
	# Flip sprite
	if direction > 0.0:
		sprite.flip_h = true
	elif direction < 0.0:
		sprite.flip_h = false
	
	# Movement
	velocity = Vector2(direction, 0.0) * speed
	move_and_slide()


func hit(damage: int, _knockback_direction: float) -> void:
	health -= damage
	
	if health <= 0:
		queue_free()
