extends CharacterBody2D


const GOAL_DISTANCE := 8
const ATTACK_B_HEALTH := 50

## The enemy default health.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 100
## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var charge_speed := 384
## The gravity is enabled.
@export var gravity_enabled := true
## The sprite is facing left by default.
@export var sprite_faces_left := true
## The enemy can be freezed.
@export var allow_freeze := true
@export_category("Reference Points")
@export var swing_left: Node2D
@export var charge_left: Node2D
@export var swing_right: Node2D
@export var charge_right: Node2D
@export var fly_left: Node2D
@export var fly_right: Node2D
@export var follow_height: Node2D
@export var dive_height: Node2D
@export_category("Nodes")
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var hit_box: Area2D
@export var loot: Node2D
@export var state_machine: FiniteStateMachine
@export var hit_state: BaseState

## The health of the enemy.
var health := max_health
## The current boss speed.
var current_speed := movement_speed
## The direction the boss is moving to.
var direction := Vector2()
## The current knockback.
var knockback := 0.0
## The enemy will be freezed for this long.
var freeze_time := 0.0
## The player reference.
var player: Node2D

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	health = max_health
	Events.boss_health_changed.emit(health, max_health)


func _physics_process(delta: float) -> void:
	# Process horizontal movement
	velocity.x = direction.x * current_speed
	
	# Freeze time
	if Globals.enemy_paralyze > 0.0:
		_freeze()
	elif freeze_time > 0.0:
		freeze_time -= delta
		
		# Play hit animation even when frozen
		if state_machine.current_state == hit_state:
			animator.speed_scale = 1.0
			sprite.modulate = Color.WHITE
		else:
			_freeze()
	else:
		_unfreeze()
	
	# Gravity logic
	if gravity_enabled:
		if is_on_floor():
			velocity.y = 0.0
		else:
			velocity.y += gravity * delta
	else:
		# Process vertical movement
		velocity.y = direction.y * current_speed
	
	# Perform the actual movement
	move_and_slide()


func hit(damage: int, _knockback_direction: float) -> void:
	health -= damage
	Events.boss_health_changed.emit(health, max_health)
	
	if health > 0:
		prints("[boss]", name, "hit:", "%d/%d" % [health, max_health])
		state_machine.current_state = hit_state
	else:
		# Death logic here
		die()


func die() -> void:
	loot.drop()
	prints("[boss]", name, "destroyed")
	Events.eagle_spawner_stopped.emit()
	Events.boss_defeated.emit()
	queue_free()


## Freezes the enemy for the given amount of time.
func freeze(time: float) -> void:
	if allow_freeze:
		freeze_time = time
		prints("[boss]", name, "frozen for:", freeze_time, "s")


func _freeze() -> void:
	velocity.x = 0.0
	animator.speed_scale = 0.0
	sprite.modulate = Color.AQUAMARINE
	hit_box.process_mode = Node.PROCESS_MODE_DISABLED
	state_machine.process_mode = Node.PROCESS_MODE_DISABLED


func _unfreeze() -> void:
	animator.speed_scale = 1.0
	sprite.modulate = Color.WHITE
	hit_box.process_mode = Node.PROCESS_MODE_INHERIT
	state_machine.process_mode = Node.PROCESS_MODE_INHERIT


func join_fight() -> void:
	Events.boss_health_changed.emit(health, max_health)
