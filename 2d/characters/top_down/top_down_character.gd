extends CharacterBody2D
class_name TopDownCharacter


## How fast the character will move around.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
@export_category("Nodes")
@export var animator: AnimationPlayer

## The direction the character is moving to.
var direction := Vector2()
## The direction the character is facing to.
var facing := Vector2.DOWN


func _physics_process(_delta: float) -> void:
	# Process character movement
	velocity = direction * movement_speed
	
	# Set facing direction
	if direction:
		facing = direction
	
	# Perform the actual movement
	move_and_slide()


## Plays the given animation based on the direction of the character.
func play_animation(left: StringName, right: StringName, up: StringName, down: StringName) -> void:
	var direction_index = posmod(int(snappedf(facing.angle(), (PI / 2.0)) / (PI / 2.0)), 4)
	animator.play([right, down, left, up][direction_index])
