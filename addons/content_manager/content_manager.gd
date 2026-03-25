@tool
extends EditorPlugin


var root: Control


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass


func _has_main_screen() -> bool:
	return true


func _make_visible(visible: bool) -> void:
	if visible:
		root = preload("res://addons/content_manager/root.tscn").instantiate()
		root.setup(self)
		EditorInterface.get_editor_main_screen().add_child(root)
	elif is_instance_valid(root):
		root.queue_free()


func _get_plugin_name() -> String:
	return "Content Manager"


func _get_plugin_icon() -> Texture2D:
	return EditorInterface.get_editor_theme().get_icon("Add", "EditorIcons")
