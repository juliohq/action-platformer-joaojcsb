extends Node2D


@export var scene: PackedScene
@export_range(1, 10, 1, "or_greater") var min_count := 1
@export_range(1, 10, 1, "or_greater") var max_count := 1


func drop() -> void:
	var count := randi_range(min_count, max_count)
	
	for i in count:
		var loot := scene.instantiate()
		loot.position = position
		Events.loot_dropped.emit(loot)
