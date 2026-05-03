extends Node2D


## The scene to be spawned.
@export var scene: PackedScene
## How fast to shoot.
@export_range(0.01, 10.0, 0.01, "or_greater", "suffix:units/s")
var fire_rate := 1.0
@export_category("Nodes")
@export var root: Node2D
@export var sprite: Sprite2D

## How fast to shoot.
var cooldown := 0.0


func _physics_process(delta: float) -> void:
	if root.freeze_time > 0.0:
		return
	
	if cooldown > 0.0:
		cooldown -= delta
	else:
		cooldown += 1.0 / fire_rate
		shoot()


func shoot() -> void:
	var bullet := scene.instantiate()
	bullet.direction.x = 1 if sprite.flip_h and root.sprite_faces_left else -1
	bullet.global_position = global_position
	Events.bullet.emit(bullet)
