extends EditorInspectorPlugin


## The current plugin.
var plugin: EditorPlugin


func _can_handle(object: Object) -> bool:
	return object is Node2D


func _parse_category(object: Object, category: String) -> void:
	if category == "Node2D":
		add_button("Invert position", &"Node2D", object, _invert_position)
		add_button("Invert rotation", &"Node2D", object, _invert_rotation)
		add_button("Invert scale", &"Node2D", object, _invert_scale)


func add_button(name: String, icon: StringName, object: Object,
		callback: Callable) -> void:
	var editor_theme := plugin.get_editor_interface().get_editor_theme()
	var button := Button.new()
	button.text = name
	button.icon = editor_theme.get_icon(icon, &"EditorIcons")
	button.pressed.connect(callback.bind(object))
	add_custom_control(button)


func _invert_position(node: Node2D) -> void:
	var undo_redo := plugin.get_undo_redo()
	undo_redo.create_action("Invert node position")
	undo_redo.add_do_property(node, "position", -node.position)
	undo_redo.add_undo_property(node, "position", node.position)
	undo_redo.commit_action()


func _invert_rotation(node: Node2D) -> void:
	var final_rotation := wrapf(node.rotation + PI, 0.0, TAU)
	
	var undo_redo := plugin.get_undo_redo()
	undo_redo.create_action("Invert node rotation")
	undo_redo.add_do_property(node, "rotation", final_rotation)
	undo_redo.add_undo_property(node, "rotation", node.rotation)
	undo_redo.commit_action()


func _invert_scale(node: Node2D) -> void:
	var undo_redo := plugin.get_undo_redo()
	undo_redo.create_action("Invert node scale")
	undo_redo.add_do_property(node, "scale", -node.scale)
	undo_redo.add_undo_property(node, "scale", node.scale)
	undo_redo.commit_action()
