extends Area2D


## Emitted when it hurts the player.
signal hit(body)


func _ready() -> void:
	body_entered.connect(_hit)


func _hit(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
	
	hit.emit(body)
