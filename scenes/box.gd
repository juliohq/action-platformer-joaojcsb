extends StaticBody2D


## The default health of the object.
@export_range(1, 10, 1, "or_greater", "suffix:HP") var max_health := 1
@export var particles_scene := preload("res://scenes/box_destruction.tscn")

var health := max_health


func _ready() -> void:
	health = max_health


func test_hit(test: StringName) -> bool:
	return test == &"attack_b"


func hit(damage: int, _knockback_direction: float) -> void:
	prints("[box] hit damage:", damage)
	health -= damage
	prints("[box] health:", health)
	
	if health <= 0:
		var particles := particles_scene.instantiate()
		particles.global_position = global_position
		Events.particles.emit(particles)
		queue_free()
