extends Control


## The control to be focused.
@export var focus_control: Control


func _ready() -> void:
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


## Handles the logic when the ok button is pressed. Override to provide custom behavior.
func _accept() -> void:
	get_tree().quit()


## Handles the logic when the cancel button is pressed. Override to provide custom behavior.
func _cancel() -> void:
	queue_free()
