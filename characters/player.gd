extends CharacterBody2D


const JUMP_SOUND := preload("res://assets/audio/player_jump.wav")
const RED_ORB_DROP := preload("res://scenes/red_orb_drop.tscn")
const BLUE_ORB_DROP := preload("res://scenes/blue_orb_drop.tscn")

const FIREBALL := preload("res://scenes/fireball.tscn")
const FIRE_GRENADE := preload("res://scenes/fire_grenade.tscn")
const FREEZE_TOUCH := preload("res://scenes/freeze_touch.tscn")
const GIANT_ICE_ORB := preload("res://scenes/giant_ice_orb.tscn")

const SLINGSHOT_AUDIO := preload("res://assets/audio/player_slingshot.wav")
const SLOT_CHANGED_AUDIO := preload("res://assets/audio/player_slot_changed.wav")

## How many orbs the power will cost.
const FIRE_GRENADE_COST := 2
## How many orbs the power will cost.
const GIANT_ICE_ORB_COST := 2

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
## How often you can use the strong power.
@export_range(0.1, 10.0, 0.01, "or_greater", "suffix:s")
var strong_power_duration := 10.0
## How often you can shoot per second.
@export_range(0.01, 10.0, 0.01, "or_greater", "suffix:s")
var invincibility := 2.0
@export_category("Nodes")
@export var sprite: Sprite2D
@export var hit_box: Area2D
@export var animator: AnimationPlayer
@export var pivot: Node2D
@export var state_machine: FiniteStateMachine
@export var jump_state: BaseState
@export var hit_state: BaseState
@export var death_state: BaseState
@export var fall_death: Node
@export var cooldown_bar: ProgressBar

## The horizontal direction the player is moving to.
var direction := 0.0
## The time left to jump.
var jump_buffer := 0.0
## The time left to jump.
var coyote_buffer := 0.0

## The current cooldown.
var cooldown := 0.0
## The current strong power cooldown.
var strong_power_cooldown := 0.0

## Invincibility time left.
var invincibility_left := invincibility
## The current attack type.
var attack := Globals.Attack.A
## The enemy will be freezed for this long.
var freeze_time := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	fall_death.dead.connect(_fall_death)
	
	prints("[player] invincible for:", invincibility_left, "s")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"change_orb"):
		get_viewport().set_input_as_handled()
		Globals.orb = ((Globals.orb + 1) % 2) as Globals.Orb
		Events.orb_changed.emit()
		AudioManager.play(SLOT_CHANGED_AUDIO, 1.0, &"Sounds")
		prints("[player] orb changed:", Globals.orb)


func _physics_process(delta: float) -> void:
	# Flip sprite logic
	if freeze_time <= 0.0:
		if direction < 0.0:
			sprite.scale.x = -1
		elif direction > 0.0:
			sprite.scale.x = 1
	
	# Jump logic (with jump buffering)
	if Input.is_action_just_pressed(&"jump") and freeze_time <= 0.0:
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
	update_cooldown_bar()
	
	strong_power_cooldown = move_toward(strong_power_cooldown, 0.0, delta)
	
	# Invincibility frames
	if invincibility_left > 0.0:
		invincibility_left -= delta
		sprite.modulate.a = fposmod(invincibility_left, 0.25) * 4.0
		
		if invincibility_left <= 0.0:
			prints("[player] invincibility ran out")
			sprite.modulate.a = 1.0
	
	# Process character movement
	velocity.x = direction * movement_speed
	
	# Freeze time
	if freeze_time > 0.0:
		freeze_time -= delta
		_freeze()
	else:
		_unfreeze()
	
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
	prints("[player] invincible for:", invincibility_left, "s")
	
	# Orb drop and die logic
	if Globals.orb == Globals.Orb.RED:
		# Drop red orb
		if Globals.red_orbs > 0:
			Globals.red_orbs -= 1
			spawn_orb(RED_ORB_DROP)
			prints("[player] red orb dropped")
			
			# Hit state
			state_machine.current_state = hit_state
		else:
			die(false)
	# Drop blue orb
	elif Globals.blue_orbs > 0:
		Globals.blue_orbs -= 1
		spawn_orb(BLUE_ORB_DROP)
		prints("[player] blue orb dropped")
		
		# Hit state
		state_machine.current_state = hit_state
	else:
		die(false)


func _fall_death() -> void:
	die(true)
	prints("[player] fell")
	
	# Reset player directions
	direction = 0.0
	sprite.scale.x = 1


func die(fallen: bool) -> void:
	Globals.player_health -= 1
	
	if Globals.player_health >= 0:
		Events.player_health_changed.emit()
	
	# Invincibility
	invincibility_left = invincibility
	
	# Freeze
	freeze_time = 0.0
	
	# Death
	if Globals.player_health <= 0:
		if fallen:
			Events.game_over.emit()
		else:
			state_machine.current_state = death_state


func spawn_orb(scene: PackedScene) -> void:
	var orb := scene.instantiate()
	orb.global_position = global_position
	Events.orb_dropped.emit(orb)


func try_shoot(attack_type: Globals.Attack) -> void:
	if cooldown > 0.0:
		return
	
	attack = attack_type
	
	if can_shoot():
		if attack == Globals.Attack.B:
			if Globals.orb == Globals.Orb.RED:
				Globals.red_orbs -= FIRE_GRENADE_COST
			else:
				Globals.blue_orbs -= GIANT_ICE_ORB_COST
			
			Events.orb_consumed.emit()
		
		state_machine.change_state("Attack")


func can_shoot() -> bool:
	if attack == Globals.Attack.A:
		return true
	
	if strong_power_cooldown <= 0.0:
		if Globals.orb == Globals.Orb.RED:
			if Globals.red_orbs >= FIRE_GRENADE_COST:
				return true
		
		if Globals.blue_orbs >= GIANT_ICE_ORB_COST:
			return true
	
	return false


func shoot() -> void:
	# Cooldown
	cooldown += 1.0 / fire_rate
	
	# Audio
	AudioManager.play(SLINGSHOT_AUDIO, 1.0, &"Sounds")
	
	# Shoot
	var bullet: Node2D
	
	if Globals.orb == Globals.Orb.RED:
		if attack == Globals.Attack.A:
			bullet = FIREBALL.instantiate()
		else:
			bullet = FIRE_GRENADE.instantiate()
			strong_power_cooldown += strong_power_duration
	elif attack == Globals.Attack.A:
		bullet = FREEZE_TOUCH.instantiate()
	else:
		bullet = GIANT_ICE_ORB.instantiate()
		strong_power_cooldown += strong_power_duration
	
	bullet.global_position = pivot.global_position
	bullet.direction.x = sprite.scale.x
	Events.bullet.emit(bullet)


## Freezes the player for the given amount of time.
func freeze(time: float) -> void:
	if invincibility_left > 0.0:
		print("[freeze] player is invincible")
		return
	
	freeze_time = time
	prints("[freeze] player frozen for:", freeze_time, "s")


func _freeze() -> void:
	velocity.x = 0.0
	animator.process_mode = Node.PROCESS_MODE_DISABLED
	sprite.self_modulate = Color.AQUAMARINE
	hit_box.process_mode = Node.PROCESS_MODE_DISABLED


func _unfreeze() -> void:
	animator.speed_scale = 1.0
	animator.process_mode = Node.PROCESS_MODE_INHERIT
	sprite.self_modulate = Color.WHITE
	hit_box.process_mode = Node.PROCESS_MODE_INHERIT


func update_cooldown_bar() -> void:
	var max_cooldown := 1.0 / fire_rate
	cooldown_bar.update(max_cooldown - cooldown, max_cooldown)


func heal() -> bool:
	if Globals.player_health <= Globals.PLAYER_HEALTH:
		if Globals.orb == Globals.Orb.RED:
			if Globals.red_orbs >= Globals.LIFE_COST:
				Globals.red_orbs -= Globals.LIFE_COST
				Globals.player_health += 1
				Events.player_health_changed.emit()
				return true
		elif Globals.blue_orbs >= Globals.LIFE_COST:
			Globals.blue_orbs -= Globals.LIFE_COST
			Globals.player_health += 1
			Events.player_health_changed.emit()
			return true
	
	return false
