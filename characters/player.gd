extends CharacterBody2D


## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
## How high the character will jump.
@export_range(1, 100, 1, "or_greater", "suffix:px") var jump_height := 384
## How long a jump will be accepted after another one.
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:s")
var jump_buffering := 0.2
## How long a jump will be accepted after falling a cliff.
@export_range(0.01, 1.0, 0.01, "or_greater", "suffix:s")
var coyote_buffering := 0.1
@export_category("Nodes")
@export var sprite: Sprite2D
@export var state_machine: FiniteStateMachine
@export var jump_state: BaseState
@export var fall_death: Node

## The horizontal direction the player is moving to.
var direction := 0.0
## The time left to jump.
var jump_buffer := 0.0
## The time left to jump.
var coyote_buffer := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	fall_death.dead.connect(die)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		get_viewport().set_input_as_handled()
		Globals.orb = ((Globals.orb + 1) % 2) as Globals.Orb
		Events.orb_changed.emit()


func _physics_process(delta: float) -> void:
	# Flip sprite logic
	if direction < 0.0:
		sprite.flip_h = true
	elif direction > 0.0:
		sprite.flip_h = false
	
	# Jump logic (with jump buffering)
	if Input.is_action_just_pressed(&"jump"):
		jump_buffer = jump_buffering
		
		if coyote_buffer > 0.0:
			jump()
			move_and_slide()
	# Variable jump height logic
	elif Input.is_action_just_released(&"jump") and velocity.y < 0.0:
		fall()
	
	if is_on_floor() and jump_buffer > 0.0:
		jump_buffer = 0.0
		jump()
		move_and_slide()
	
	# Jump buffer
	if jump_buffer > 0.0:
		jump_buffer -= delta
	else:
		jump_buffer = 0.0
	
	# Coyote buffer
	if coyote_buffer > 0.0:
		coyote_buffer -= delta
	else:
		coyote_buffer = 0.0
	
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
	state_machine.current_state = jump_state


## Makes the character start falling (usually after a jump).
func fall() -> void:
	velocity.y = 0.0


func hit() -> void:
	if Globals.blue_orbs > 0:
		# Drop blue orb
		Globals.blue_orbs -= 1
		Events.orb_dropped.emit()
	elif Globals.red_orbs > 0:
		# Drop red orb
		Globals.red_orbs -= 1
		Events.orb_dropped.emit()
	else:
		die()


func die() -> void:
	Globals.player_health -= 1
	Events.player_health_changed.emit()
	
	# Death
	if Globals.player_health <= 0:
		Events.game_over.emit()
