extends CharacterBody2D


## The enemy default health.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 3
## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
@export_category("Nodes")
@export var hit_box: Area2D

## The health of the enemy.
var health := max_health
## The horizontal direction the player is moving to.
var direction := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	health = max_health


func _physics_process(delta: float) -> void:
	# Process character movement
	velocity.x = direction * movement_speed
	
	# Gravity logic
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += gravity * delta
	
	# Perform the actual movement
	move_and_slide()


func hit(damage: int) -> void:
	health -= damage
	
	if health > 0:
		# Knockback
		pass
	else:
		# Death logic here
		queue_free()
