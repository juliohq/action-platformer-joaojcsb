extends Area2D


## Emitted when it hurts the player.
signal hit(body: Node2D)

## Apply damage when a body enters the hit box.
## otherwise, attack will be manual.
@export var on_enter := true
## How much health this hitbox will take from enemies.
@export_range(0, 10, 1, "or_greater", "suffix:HP") var attack := 1
@export var hit_test := &""


func _ready() -> void:
	if on_enter:
		body_entered.connect(_hit)


func _hit(body: Node2D) -> void:
	if body.has_method("hit"):
		if body.has_method("test_hit"):
			if not body.test_hit(hit_test):
				return
		
		hit.emit(body)
		body.hit(attack, signf(body.global_position.x - global_position.x))


func damage() -> void:
	for body: Node2D in get_overlapping_bodies():
		if body.has_method("hit"):
			body.hit(attack, signf(body.global_position.x - global_position.x))
			hit.emit(body)
			return
