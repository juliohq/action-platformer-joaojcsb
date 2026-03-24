extends CharacterBody3D


## How fast the player can walk around.
@export_range(1, 35, 1) var speed := 10.0 # m/s
## How fast the player reaches maximum speed.
@export_range(10, 400, 1) var acceleration := 100.0 # m/s^2
## How heavy the player is.
@export_range(0.01, 10.0, 0.01) var weight := 4.0 # kg
## How tall the player is able to jump.
@export_range(0.1, 3.0, 0.1) var jump_height := 0.75 # m
## Hwo fast the camera will look around (mouse).
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sensitivity := 10.0
## Hwo fast the camera will look around (joypad).
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_joypad_sensitivity := 1.0

var gravity: float = ProjectSettings.get_setting(&"physics/3d/default_gravity")
var mouse_captured := false
var target_vel := Vector3()

@onready var camera := $Camera


func _ready() -> void:
	capture_mouse()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if mouse_captured:
			get_viewport().set_input_as_handled()
			_rotate_camera(event.relative * 0.001)


func _physics_process(delta: float) -> void:
	velocity = Vector3(0.0, velocity.y, 0.0)
	
	# Movement logic
	var move_dir := Input.get_vector(&"left", &"right", &"up", &"down")
	var forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0.0, move_dir.y)
	var walk_dir := Vector3(forward.x, 0.0, forward.z).normalized()
	target_vel = target_vel.move_toward(walk_dir * speed, acceleration * delta)
	velocity += Vector3(target_vel.x, 0.0, target_vel.z)
	
	if is_on_floor():
		# Jump logic
		if Input.is_action_just_pressed(&"jump"):
			get_viewport().set_input_as_handled()
			jump()
		else:
			velocity.y = 0.0
	else:
		# Gravity logic
		velocity.y -= weight * gravity * delta
	
	# Joypad look around logic
	if mouse_captured:
		var joypad := Input.get_vector(&"look_left", &"look_right", &"look_up", &"look_down")
		
		if joypad.length() > 0:
			_rotate_camera(joypad * delta)
	
	move_and_slide()


func capture_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true


func release_mouse() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false


func _rotate_camera(offset: Vector2) -> void:
	camera.rotation.y -= offset.x * camera_sensitivity
	camera.rotation.x = clamp(camera.rotation.x - offset.y * camera_sensitivity, -1.5, 1.5)


func jump() -> void:
	velocity.y = sqrt(4.0 * jump_height * gravity)
