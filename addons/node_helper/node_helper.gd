@tool
extends EditorPlugin


## The inspector plugin for Node2D nodes.
var node_2d_inspector: EditorInspectorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	node_2d_inspector = preload("res://addons/node_helper/node_2d_inspector.gd").new()
	node_2d_inspector.plugin = self
	add_inspector_plugin(node_2d_inspector)


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_inspector_plugin(node_2d_inspector)
