extends EditorInspectorPlugin


## The current plugin.
var plugin: EditorPlugin


func _can_handle(object: Object) -> bool:
	return object is Camera2D


func _parse_category(object: Object, category: String) -> void:
	if category != "Camera2D":
		return
	
	add_button("Reset limits", &"Camera2D", object, _reset_limits)
	
	if is_instance_valid(object.owner):
		var owner: Node = object.owner
		
		if owner.find_children("*", "TileMapLayer"):
			add_button("Set limits to TileMapLayer", &"Camera2D", object,
					_set_tilemap_limits)


func add_button(name: String, icon: StringName, object: Object,
		callback: Callable) -> void:
	var editor_theme := plugin.get_editor_interface().get_editor_theme()
	var button := Button.new()
	button.text = name
	button.icon = editor_theme.get_icon(icon, &"EditorIcons")
	button.pressed.connect(callback.bind(object))
	add_custom_control(button)


func _reset_limits(node: Camera2D) -> void:
	var limit := 10_000_000
	node.limit_left = -10_000_000
	node.limit_right = 10_000_000
	node.limit_top = -10_000_000
	node.limit_bottom = 10_000_000


func _set_tilemap_limits(node: Camera2D) -> void:
	var owner: Node = node.owner
	var layers = owner.find_children("*", "TileMapLayer")
	
	# Find used rect
	var used_rect := Rect2i()
	
	for layer: TileMapLayer in layers:
		# Get tile size
		var tile_size := Vector2i()
		
		if layer.tile_set:
			tile_size = layer.tile_set.tile_size
		
		# Calculate final used rect
		var rect: Rect2i = layer.get_used_rect()
		rect.position *= tile_size
		rect.size *= tile_size
		used_rect = used_rect.merge(rect)
	
	# Apply used rect
	if used_rect:
		var undo_redo := plugin.get_undo_redo()
		undo_redo.create_action("Set limits to TileMapLayer")
		
		# Do
		undo_redo.add_do_property(node, "limit_left", used_rect.position.x)
		undo_redo.add_do_property(node, "limit_right", used_rect.end.x)
		undo_redo.add_do_property(node, "limit_top", used_rect.position.y)
		undo_redo.add_do_property(node, "limit_bottom", used_rect.end.y)
		
		# Undo
		undo_redo.add_undo_property(node, "limit_left", node.limit_left)
		undo_redo.add_undo_property(node, "limit_right", node.limit_right)
		undo_redo.add_undo_property(node, "limit_top", node.limit_top)
		undo_redo.add_undo_property(node, "limit_bottom", node.limit_bottom)
		
		undo_redo.commit_action()
