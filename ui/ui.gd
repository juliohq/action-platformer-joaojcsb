extends CanvasLayer


func _ready() -> void:
	Events.ui_updated.connect(_update)
	Events.game_over.connect(_game_over)
	
	_update()


## Handles the logic when the UI is updated. Override to provide custom behavior.
func _update() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(preload("res://ui/pause.tscn").instantiate())


func _game_over() -> void:
	add_child(preload("res://ui/game_over.tscn").instantiate())
