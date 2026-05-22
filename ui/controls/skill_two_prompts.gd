extends Control


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("heal"):
		get_viewport().set_input_as_handled()
		queue_free()
