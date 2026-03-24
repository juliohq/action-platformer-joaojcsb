extends Node


## A node that randomly hides the given set of nodes.


@export_range(0.0, 1.0, 0.01) var probability := 0.5
@export var nodes: Array[Node3D]


func _ready() -> void:
	if randf() < 0.5:
		for node: Node3D in nodes:
			node.hide()
