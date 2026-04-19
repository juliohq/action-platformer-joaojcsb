extends VisibleOnScreenNotifier2D


## The node to be despawned.
@export var parent: Node


func _ready() -> void:
	screen_exited.connect(_screen_exited)


func _screen_exited() -> void:
	parent.queue_free()
