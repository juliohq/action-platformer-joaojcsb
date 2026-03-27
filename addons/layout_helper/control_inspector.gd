extends EditorInspectorPlugin


## The current plugin.
var plugin: EditorPlugin


func _can_handle(object: Object) -> bool:
	return object is Control


func _parse_begin(object: Object) -> void:
	add_button("Set minimum size", &"Control", object, _set_minimum_size,
			"Copies the current size to the custom_minimum_size property.")
	add_button("PanelContainer + VBoxContainer", &"PanelContainer", object,
			_panel_container_vbox, "Add a panel and a vertrical box container.")
	add_button("PanelContainer + Margin + VBoxContainer", &"PanelContainer",
			object, _panel_container_margin_vbox,
			"Add a panel, a margin and a vertrical box container.")
	add_button("Add centered panel", &"PanelContainer",
			object, _centered_panel,
			"Add a centered panel, margin, vertical box container and label.")


func add_button(name: String, icon: StringName, object: Object,
		callback: Callable, tooltip_text := "") -> void:
	var editor_theme := plugin.get_editor_interface().get_editor_theme()
	var button := Button.new()
	button.text = name
	button.icon = editor_theme.get_icon(icon, &"EditorIcons")
	button.tooltip_text = tooltip_text
	button.pressed.connect(callback.bind(object))
	add_custom_control(button)


func _set_minimum_size(control: Control) -> void:
	var undo_redo := plugin.get_undo_redo()
	undo_redo.create_action("Set Control minimum size")
	undo_redo.add_do_property(control, "custom_minimum_size", control.size)
	undo_redo.add_undo_property(control, "custom_minimum_size",
			control.custom_minimum_size)
	undo_redo.commit_action()


func _panel_container_vbox(parent: Control) -> void:
	var panel_container := PanelContainer.new()
	var vbox := VBoxContainer.new()
	panel_container.add_child(vbox, true)
	parent.add_child(panel_container, true)
	
	# Set owner
	set_node_owner(panel_container, parent)
	set_node_owner(vbox, parent)


func _panel_container_margin_vbox(parent: Control) -> void:
	var panel_container := PanelContainer.new()
	var margin := MarginContainer.new()
	var vbox := VBoxContainer.new()
	margin.add_child(vbox, true)
	panel_container.add_child(margin, true)
	parent.add_child(panel_container, true)
	
	# Set owner
	set_node_owner(panel_container, parent)
	set_node_owner(margin, parent)
	set_node_owner(vbox, parent)


func _centered_panel(parent: Control) -> void:
	var panel_container := PanelContainer.new()
	var margin := MarginContainer.new()
	var vbox := VBoxContainer.new()
	var label := Label.new()
	vbox.add_child(label, true)
	margin.add_child(vbox, true)
	panel_container.add_child(margin, true)
	parent.add_child(panel_container, true)
	
	# Set owner
	set_node_owner(panel_container, parent)
	set_node_owner(margin, parent)
	set_node_owner(vbox, parent)
	set_node_owner(label, parent)


func set_node_owner(child: Node, parent: Node) -> void:
	if is_instance_valid(parent.owner):
		child.owner = parent.owner
	else:
		child.owner = parent
