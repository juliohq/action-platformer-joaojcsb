extends EditorInspectorPlugin


## The current plugin.
var plugin: EditorPlugin


func _can_handle(object: Object) -> bool:
	return object is MarginContainer


func _parse_category(object: Object, category: String) -> void:
	if category == "Control":
		add_button("Reset margins", &"MarginContainer", object, _reset_margins)


func add_button(name: String, icon: StringName, object: Object,
		callback: Callable) -> void:
	var editor_theme := plugin.get_editor_interface().get_editor_theme()
	var button := Button.new()
	button.text = name
	button.icon = editor_theme.get_icon(icon, &"EditorIcons")
	button.pressed.connect(callback.bind(object))
	add_custom_control(button)


func _reset_margins(control: MarginContainer) -> void:
	var undo_redo := plugin.get_undo_redo()
	undo_redo.create_action("Reset node margins")
	_reset_margin(control, &"margin_left", undo_redo)
	_reset_margin(control, &"margin_right", undo_redo)
	_reset_margin(control, &"margin_top", undo_redo)
	_reset_margin(control, &"margin_bottom", undo_redo)
	undo_redo.commit_action()


func _reset_margin(control: MarginContainer, constant: StringName,
		undo_redo: EditorUndoRedoManager) -> void:
	undo_redo.add_do_method(control, &"remove_theme_constant_override",
			constant)
	
	if control.has_theme_constant_override(constant):
		var margin := control.get_theme_constant(constant)
		undo_redo.add_undo_method(control, &"add_theme_constant_override",
			constant, margin)
