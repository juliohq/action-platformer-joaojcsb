extends CharacterBody2D
class_name EndlessRunnerCharacter2D


## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
## How high the character will jump.
@export_range(1, 100, 1, "or_greater", "suffix:px") var jump_height := 512

## The horizontal direction the player is moving to.
var direction := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


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


## Makes the character jump upwards.
func jump() -> void:
	velocity.y = -jump_height


## Makes the character start falling (usually after a jump).
func fall() -> void:
	velocity.y = 0.0
