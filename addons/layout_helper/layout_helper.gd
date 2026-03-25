@tool
extends EditorPlugin


## The inspector plugin for Control nodes.
var control_inspector: EditorInspectorPlugin
## The inspector plugin for MarginContainer nodes.
var margin_container_inspector: EditorInspectorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	margin_container_inspector = preload("res://addons/layout_helper/margin_container_inspector.gd").new()
	margin_container_inspector.plugin = self
	add_inspector_plugin(margin_container_inspector)
	
	control_inspector = preload("res://addons/layout_helper/control_inspector.gd").new()
	control_inspector.plugin = self
	add_inspector_plugin(control_inspector)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_inspector_plugin(margin_container_inspector)
	remove_inspector_plugin(control_inspector)
