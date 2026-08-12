extends CanvasLayer


func _ready() -> void:
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"console"):
		get_viewport().set_input_as_handled()
		visible = not visible
