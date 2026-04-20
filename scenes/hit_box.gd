extends Area2D


## Emitted when it hurts the player.
signal hit(body)

## How much health this hitbox will take from enemies.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var attack := 1


func _ready() -> void:
	body_entered.connect(_hit)


func _hit(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit(attack)
	
	hit.emit(body)
