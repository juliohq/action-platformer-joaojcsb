extends VisibleOnScreenNotifier2D


## The parent node to be removed.
@export var parent: Node

## The node entered the screen at least once.
var entered := false


func _ready() -> void:
	screen_entered.connect(_screen_entered)
	screen_exited.connect(_screen_exited)


func _screen_entered() -> void:
	entered = true


func _screen_exited() -> void:
	if entered:
		parent.queue_free()
