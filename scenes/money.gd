extends Area2D


@export_range(1, 10, 1, "or_greater") var amount := 1
@export_category("Nodes")
@export var collectible: Area2D


func _ready() -> void:
	collectible.picked_up.connect(_picked_up)


func _picked_up() -> void:
	queue_free()
