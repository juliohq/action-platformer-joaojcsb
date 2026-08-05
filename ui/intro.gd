extends MarginContainer


## Emitted when the next is played.
signal next()

@export var main_menu: PackedScene


func _ready() -> void:
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	
	for child: Node in get_children():
		if child is VideoStreamPlayer:
			child.show()
			child.play()
			child.finished.connect(_finished)
			await next
			child.stop()
			child.hide()
	
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	get_tree().change_scene_to_packed(main_menu)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_1"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_2_hold"):
		get_viewport().set_input_as_handled()
		_finished()
	elif event.is_action_pressed("attack_2_press"):
		get_viewport().set_input_as_handled()
		_finished()


func _finished() -> void:
	next.emit()
