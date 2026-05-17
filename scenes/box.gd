extends StaticBody2D


const BOX_DESTRUCTION := preload("res://scenes/box_destruction.tscn")

## The default health of the object.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 1

var health := max_health


func _ready() -> void:
	health = max_health


func hit(damage: int, _knockback_direction: float) -> void:
	health -= damage
	
	if health <= 0:
		var particles := BOX_DESTRUCTION.instantiate()
		particles.global_position = global_position
		Events.particles.emit(particles)
		queue_free()
