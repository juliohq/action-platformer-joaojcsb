extends Node3D



## Reset the camera smoothing onready.
@export var reset_onready := true
@export_group("Movement")
## How fast the camera will move.
@export_range(0, 1024, 1, "suffix:m/s") var camera_speed := 8
## How fast the camera movement will each its target speed.
@export_range(0, 1024, 1, "suffix:m/s") var camera_smoothing_speed := 16
## Camera drag margin in percentage.
@export_range(0.0, 1.0, 0.01, "suffix:%") var drag_margin := 0.05
@export_group("Rotation")
## Rotate to the left when this actions is pressed.
@export var rotate_left := &"left"
## Rotate to the right when this actions is pressed.
@export var rotate_right := &"right"
## How fast the camera will rotate.
@export_range(0.0, 360.0, 0.1, "radians_as_degrees")
var rotation_speed := 3.141592
## How fast the rotation will reach its target.
@export_range(0.0, 360.0, 0.1, "radians_as_degrees")
var rotation_smoothness := 6.28318
@export_group("Zoom")
## How high the camera is allowed to be.
@export_range(0.0, 200.0, 0.01, "suffix:m") var max_height := 8.0
## How low the camera is allowed to be.
@export_range(0.0, 200.0, 0.01, "suffix:m") var min_height := 0.5
## What maximum distance the camera is allowed to be from the origin.
@export_range(0.0, 200.0, 0.01, "suffix:m") var max_distance := 4.0
## What minimum distance the camera is allowed to be from the origin.
@export_range(0.0, 200.0, 0.01, "suffix:m") var min_distance := 1.0
## How fast the zoom will change.
@export_range(0.01, 1.0, 0.01, "suffix:%") var zoom_sensitivity := 0.15
## How fast the zoom will reach its target.
@export_range(0, 128, 0) var zoom_smoothness := 12

## The camera movement velocity.
var velocity := Vector3()
## A helper variable that tells what rotation the camera is trying to achieve.
var target_rotation := 0.0

## A helper variable that tells what height the camera is trying to achieve.
@onready var target_height := max_height

@onready var elevation = $Elevation
@onready var camera = $Elevation/Camera


func _ready() -> void:
	if reset_onready:
		target_height = clampf(target_height, min_height, max_height)
		elevation.position.y = target_height
		# Fix: first frame when restarting the scene
		_process(0.0)


func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion
			and event.button_mask & MOUSE_BUTTON_MASK_MIDDLE):
		get_viewport().set_input_as_handled()
		var sensibility = (clampf(target_height / max_height, 0.5, 4.0)
				* get_process_delta_time())
		translate(-Vector3(event.relative.x, 0, event.relative.y) * sensibility)
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			get_viewport().set_input_as_handled()
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			get_viewport().set_input_as_handled()
			zoom_out()


func _process(delta: float) -> void:
	# Camera translation logic
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		var viewport_size = get_viewport().size
		var mouse_pos = get_viewport().get_mouse_position()
		var margin = viewport_size * drag_margin
		
		# Mouse border movement logic
		var offset = Vector2()
		offset.x += (int(mouse_pos.x > viewport_size.x - margin.x)
				- int(mouse_pos.x < margin.x))
		offset.y += (int(mouse_pos.y > viewport_size.y - margin.y)
				- int(mouse_pos.y < margin.y))
		
		# Keyboard/gamepad movement
		offset += Input.get_vector(&"left", &"right", &"up", &"down")
		
		# Normalize offset vector
		offset = offset.normalized()
		
		velocity = velocity.lerp(
				Vector3(offset.x, 0, offset.y) * camera_speed,
				camera_smoothing_speed * delta)
		translate(velocity * delta)
	
	# Camera rotation logic
	target_rotation = lerpf(target_rotation,
			Input.get_axis(rotate_left, rotate_right) * rotation_speed,
			rotation_smoothness * delta)
	rotation.y += target_rotation * delta
	
	# Camera zoom logic
	elevation.position.z = remap(elevation.position.y, min_height, max_height,
			min_distance, max_distance)
	elevation.position.y = lerpf(elevation.position.y,
			target_height, zoom_smoothness * delta)
	
	camera.look_at(global_position)


func zoom_in() -> void:
	target_height -= zoom_sensitivity * lerpf(1.0, 4.0, get_zoom_level())
	target_height = clampf(target_height, min_height, max_height)


func zoom_out() -> void:
	target_height += zoom_sensitivity * lerpf(1.0, 4.0, get_zoom_level())
	target_height = clampf(target_height, min_height, max_height)


## Returns the actual zoom level between 0.0-1.0.
func get_zoom_level() -> float:
	return (elevation.position.y - min_height) / (max_height - min_height)
