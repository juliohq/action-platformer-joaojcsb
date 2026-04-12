extends Node2D


@export var scene: PackedScene
@export_range(1, 10, 1, "or_greater") var count := 1


func drop() -> void:
	for i in count:
		var loot := scene.instantiate()
		loot.position = position
		Events.loot_dropped.emit(loot)
