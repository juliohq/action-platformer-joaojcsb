extends VisibleOnScreenNotifier2D


@export var parent: Node


func _ready() -> void:
	screen_entered.connect(_screen_entered)
	
	parent.process_mode = Node.PROCESS_MODE_DISABLED


func _screen_entered() -> void:
	parent.process_mode = Node.PROCESS_MODE_INHERIT
	queue_free()
