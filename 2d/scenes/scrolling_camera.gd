extends Camera2D


@export var reset_smoothing_on_ready := true
@export_range(1, 200, 1, "or_greater", "suffix:px/s") var speed := 256
@export_flags("Left", "Middle", "Right") var mouse_scroll_mask := MOUSE_BUTTON_MASK_MIDDLE | MOUSE_BUTTON_MASK_RIGHT
@export var terrain: TileMapLayer


func _ready() -> void:
	if reset_smoothing_on_ready:
		# Reset smoothing is deferred so other actions performed on the frame
		# will take effect (e.g. change position of the player onready)
		reset_smoothing.call_deferred()
	
	var bounds := terrain.get_used_rect()
	limit_left = bounds.position.x * terrain.tile_set.tile_size.x
	limit_right = bounds.end.x * terrain.tile_set.tile_size.x
	limit_top = bounds.position.y * terrain.tile_set.tile_size.y
	limit_bottom = bounds.end.y * terrain.tile_set.tile_size.y


func _process(delta: float) -> void:
	# Camera movement
	var direction := Input.get_vector("left", "right", "up", "down")
	translate(direction * speed * delta)
	
	# Clamp position to camera bounds
	clamp_position()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask & mouse_scroll_mask:
			get_viewport().set_input_as_handled()
			
			if event.is_pressed():
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		elif event.is_released():
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseMotion:
		if event.button_mask & mouse_scroll_mask:
			get_viewport().set_input_as_handled()
			position -= event.relative


func clamp_position() -> void:
	var camera_size := get_viewport_rect().size
	var camera_half := camera_size / 2.0
	var begin := Vector2(limit_left, limit_top) + camera_half
	var end := Vector2(limit_right, limit_bottom) - camera_half
	position = position.clamp(begin, end)
