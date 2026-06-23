extends Control


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		queue_free()
	elif %Proceed.visible:
		if event is InputEventKey and event.is_pressed():
			get_viewport().set_input_as_handled()
			queue_free()
		elif event is InputEventJoypadButton and event.is_pressed():
			get_viewport().set_input_as_handled()
			queue_free()


func _process(delta: float) -> void:
	if %Progress.value >= %Progress.max_value:
		%Progress.hide()
		%Proceed.show()
	else:
		%Progress.value += delta
