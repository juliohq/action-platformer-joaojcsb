extends CharacterBody2D


## The enemy default health.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 3
## How fast the character will move along the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var movement_speed := 128
## How much is the default knockback on the X axis.
@export_range(1, 100, 1, "or_greater", "suffix:px/s")
var default_knockback := 96
## How fast the knockback will reset.
@export_range(1, 100, 1, "or_greater", "suffix:px/s") var knockback_speed := 192
## The sprite is facing left by default.
@export var sprite_faces_left := true
## The enemy can be freezed.
@export var allow_freeze := true
@export_category("Nodes")
@export var sprite: Sprite2D
@export var animator: AnimationPlayer
@export var hit_box: Area2D
@export var loots: Array[Node2D]
@export var health_bar: ProgressBar
@export var state_machine: FiniteStateMachine
@export var hit_state: BaseState

## The health of the enemy.
var health := max_health
## The horizontal direction the player is moving to.
var direction := 0.0
## The current knockback.
var knockback := 0.0
## The enemy will be freezed for this long.
var freeze_time := 0.0

@onready var gravity = ProjectSettings.get_setting_with_override(&"physics/2d/default_gravity")


func _ready() -> void:
	health = max_health
	
	health_bar.update(health, max_health)


func _physics_process(delta: float) -> void:
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
	
	# Knockback
	knockback = move_toward(knockback, 0.0, knockback_speed * delta)
	velocity.x += knockback
	
	# Perform the actual movement
	move_and_slide()


func hit(damage: int, knockback_direction: float) -> void:
	health -= damage
	health_bar.show()
	health_bar.update(health, max_health)
	
	if health > 0:
		state_machine.current_state = hit_state
		
		# Knockback
		knockback = default_knockback * knockback_direction
	else:
		# Death logic here
		die()


func die() -> void:
	for loot: Node2D in loots:
		loot.drop()
	
	queue_free()


func freeze(time: float) -> void:
	if allow_freeze:
		freeze_time = time


func _freeze() -> void:
	velocity.x = 0.0
	animator.speed_scale = 0.0
	sprite.modulate = Color.AQUAMARINE


func _unfreeze() -> void:
	animator.speed_scale = 1.0
	sprite.modulate = Color.WHITE
