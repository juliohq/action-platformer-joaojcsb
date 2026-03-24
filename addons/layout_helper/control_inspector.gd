extends EditorInspectorPlugin


## The current plugin.
var plugin: EditorPlugin


func _can_handle(object: Object) -> bool:
	return object is Control


func _parse_begin(object: Object) -> void:
	add_button("PanelContainer + VBoxContainer", &"PanelContainer", object,
			_panel_container_vbox)
	add_button("PanelContainer + Margin + VBoxContainer", &"PanelContainer", object,
			_panel_container_margin_vbox)


func add_button(name: String, icon: StringName, object: Object,
		callback: Callable) -> void:
	var button := Button.new()
	button.text = name
	button.icon = plugin.get_editor_interface().get_editor_theme().get_icon(icon, &"EditorIcons")
	button.pressed.connect(callback.bind(object))
	add_custom_control(button)


func _panel_container_vbox(parent: Control) -> void:
	if is_instance_valid(parent.owner):
		var panel_container := PanelContainer.new()
		var vbox := VBoxContainer.new()
		panel_container.add_child(vbox, true)
		parent.add_child(panel_container, true)
		
		# Set owner
		panel_container.owner = parent.owner
		vbox.owner = parent.owner


func _panel_container_margin_vbox(parent: Control) -> void:
	var panel_container := PanelContainer.new()
	var margin := MarginContainer.new()
	var vbox := VBoxContainer.new()
	margin.add_child(vbox, true)
	panel_container.add_child(margin, true)
	parent.add_child(panel_container, true)
	
	# Set owner
	panel_container.owner = parent.owner
	margin.owner = parent.owner
	vbox.owner = parent.owner
