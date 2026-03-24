extends Control


@export var focus_control: Control
@export_file("*.tscn") var previous_scene := "res://ui/main_menu.tscn"


func _ready() -> void:
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


func _back() -> void:
	queue_free()
