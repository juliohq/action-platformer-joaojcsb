extends VisibleOnScreenNotifier2D


@export var parent: Node

var entered := false


func _screen_entered() -> void:
	entered = true


func _screen_exited() -> void:
	if entered:
		parent.queue_free()
