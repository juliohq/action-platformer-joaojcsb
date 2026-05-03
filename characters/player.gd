extends CharacterBody2D


const JUMP_SOUND := preload("res://assets/audio/player_jump.wav")

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
## How often you can shoot per second.
@export_range(1, 10, 1, "or_greater", "suffix:units/s") var fire_rate := 2
## How often you can shoot per second.
@export_range(0.01, 10.0, 0.01, "or_greater", "suffix:s")
var invincibility := 2.0
@export_category("Nodes")
@export var sprite: Sprite2D
@export var pivot: Node2D
@export var state_machine: FiniteStateMachine
@export var jump_state: BaseState
@export var fall_death: Node

## The horizontal direction the player is moving to.
var direction := 0.0
## The time left to jump.
var jump_buffer := 0.0
## The time left to jump.
var coyote_buffer := 0.0
## The current cooldown.
var cooldown := 0.0
## Invincibility time left.
var invincibility_left := invincibility
## The current attack type.
var attack := Globals.Attack.A

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	fall_death.dead.connect(_fall_death)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"change_orb"):
		get_viewport().set_input_as_handled()
		Globals.orb = ((Globals.orb + 1) % 2) as Globals.Orb
		Events.orb_changed.emit()


func _physics_process(delta: float) -> void:
	# Flip sprite logic
	if direction < 0.0:
		sprite.scale.x = -1
	elif direction > 0.0:
		sprite.scale.x = 1
	
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
	
	# Cooldown
	cooldown = move_toward(cooldown, 0.0, delta)
	
	# Invincibility frames
	if invincibility_left > 0.0:
		invincibility_left -= delta
		sprite.modulate.a = fposmod(invincibility_left, 0.25) * 4.0
		
		if invincibility_left <= 0.0:
			sprite.modulate.a = 1.0
	
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
	AudioManager.play(JUMP_SOUND, 1.0, &"Sounds")
	velocity.y = -jump_height
	state_machine.current_state = jump_state


## Makes the character start falling (usually after a jump).
func fall() -> void:
	velocity.y = 0.0


func hit(_damage: int, _knockback_direction: float) -> void:
	# Invincibility
	if invincibility_left > 0.0:
		return
	
	invincibility_left = invincibility
	
	if Globals.red_orbs > 0:
		# Drop red orb
		Globals.red_orbs -= 1
		spawn_orb(preload("res://scenes/red_orb_drop.tscn"))
	elif Globals.blue_orbs > 0:
		# Drop blue orb
		Globals.blue_orbs -= 1
		spawn_orb(preload("res://scenes/blue_orb_drop.tscn"))
	else:
		die()


func _fall_death() -> void:
	die()
	
	# Reset player direction
	direction = 0.0
	sprite.scale.x = 1


func die() -> void:
	Globals.player_health -= 1
	Events.player_health_changed.emit()
	
	# Death
	if Globals.player_health <= 0:
		Events.game_over.emit()


func spawn_orb(scene: PackedScene) -> void:
	var orb := scene.instantiate()
	orb.global_position = global_position
	Events.orb_dropped.emit(orb)


func try_shoot(attack_type: Globals.Attack) -> void:
	if cooldown <= 0.0:
		attack = attack_type
		state_machine.change_state("Attack")


func shoot() -> void:
	# Shoot
	var bullet: Node2D
	
	if Globals.orb == Globals.Orb.RED:
		if attack == Globals.Attack.A:
			bullet = preload("res://scenes/fireball.tscn").instantiate()
		else:
			bullet = preload("res://scenes/fire_grenade.tscn").instantiate()
	elif attack == Globals.Attack.A:
		bullet = preload("res://scenes/freeze_touch.tscn").instantiate()
	else:
		bullet = preload("res://scenes/giant_ice_orb.tscn").instantiate()
	
	bullet.global_position = pivot.global_position
	bullet.direction.x = sprite.scale.x
	Events.bullet.emit(bullet)
	
	# Cooldown
	cooldown += 1.0 / fire_rate
