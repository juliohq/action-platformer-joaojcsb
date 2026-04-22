extends Node2D


@export var scene: PackedScene
@export_range(0, 10, 1, "or_greater") var min_count := 1
@export_range(0, 10, 1, "or_greater") var max_count := 1
@export_range(1, 100, 1, "or_greater", "suffix:px") var radius := 16


func drop() -> void:
	var count := randi_range(min_count, max_count)
	
	for i in count:
		spawn()


func spawn() -> void:
	var loot := scene.instantiate()
	var offset := Vector2.from_angle(TAU * randf()) * radius
	loot.global_position = global_position + offset
	Events.loot_dropped.emit(loot)
