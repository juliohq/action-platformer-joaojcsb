extends CharacterBody3D


@export_range(1.0, 500.0, 0.1, "suffix:m/s") var movement_speed := 5.0
@export_range(1.0, 500.0, 0.1, "suffix:m/s") var friction := 40.0
@export_range(1.0, 500.0, 0.01, "suffix:m/s") var jump_velocity := 4.5
@export_range(0.01, 1.0, 0.01) var mouse_sensitivity := 0.25
@export_range(-180, 180, 1, "radians_as_degrees")
var pitch_lower_limit := deg_to_rad(-90.0)
@export_range(-180, 180, 1, "radians_as_degrees")
var pitch_upper_limit := deg_to_rad(90.0)

var gravity = ProjectSettings.get_setting(&"physics/3d/default_gravity")

@onready var camera = $Camera


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_viewport().set_input_as_handled()
		var delta = mouse_sensitivity * get_process_delta_time()
		
		# Yaw
		rotate(Vector3.DOWN, event.relative.x * delta)
		
		# Pitch
		var pitch = event.relative.y * delta
		camera.rotation.x = clampf(camera.rotation.x - pitch,
				pitch_lower_limit, pitch_upper_limit)


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement
	var input_dir = Input.get_vector(&"left", &"right", &"up", &"down")
	
	var direction = Vector3(input_dir.x, 0.0, input_dir.y)
	direction = (transform.basis * direction).normalized()
	
	# Handle acceleration/deacceleration
	if direction:
		var target = Vector3(direction.x * movement_speed,
				velocity.y, direction.z * movement_speed)
		velocity = velocity.move_toward(target, friction * delta)
	else:
		velocity = Vector3(velocity.x, velocity.y,
				velocity.z).move_toward(Vector3(0.0, velocity.y, 0.0),
				friction * delta)
	
	if is_on_floor():
		# Handle jump logic
		if Input.is_action_just_pressed(&"jump"):
			velocity.y = jump_velocity
	else:
		# Add the gravity
		velocity.y -= gravity * delta
	
	move_and_slide()
