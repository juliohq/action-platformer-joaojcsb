extends CharacterBody2D


## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
## How high the character will jump.
@export_range(1, 100, 1, "or_greater", "suffix:px") var jump_height := 384
## How long a jump will be accepted.
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:s")
var jump_buffering := 0.2
@export_category("Nodes")
@export var sprite: Sprite2D
@export var state_machine: FiniteStateMachine
@export var jump_state: BaseState

## The horizontal direction the player is moving to.
var direction := 0.0
## The time left to jump.
var jump_buffer := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Flip sprite logic
	if direction < 0.0:
		sprite.flip_h = true
	elif direction > 0.0:
		sprite.flip_h = false
	
	# Jump logic (with jump buffering)
	if Input.is_action_just_pressed(&"jump"):
		jump_buffer = jump_buffering
	# Variable jump height logic
	elif Input.is_action_just_released(&"jump") and velocity.y < 0.0:
		fall()
	
	if is_on_floor() and jump_buffer > 0.0:
		jump_buffer = 0.0
		jump()
		move_and_slide()
	
	# Uncomment to enable
	# Note: Remember to disable the same logic in _unhandled_input
	# Hold jump logic
	#if Input.is_action_pressed(&"jump") and is_on_floor():
		#jump()
	
	# Process character movement
	velocity.x = direction * movement_speed
	
	# Gravity logic
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += gravity * delta
	
	# Jump buffer
	if jump_buffer > 0.0:
		jump_buffer -= delta
	else:
		jump_buffer = 0.0
	
	# Perform the actual movement
	move_and_slide()


## Makes the character jump upwards.
func jump() -> void:
	velocity.y = -jump_height
	state_machine.current_state = jump_state


## Makes the character start falling (usually after a jump).
func fall() -> void:
	velocity.y = 0.0
