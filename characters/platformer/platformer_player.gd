extends PlatformerCharacter
class_name PlatformerPlayer


@onready var sprite: Sprite2D = $Sprite


func _physics_process(delta: float) -> void:
	# Flip sprite logic
	if direction < 0.0:
		sprite.flip_h = true
	elif direction > 0.0:
		sprite.flip_h = false
	
	# Jump logic
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		jump()
		move_and_slide()
	# Variable jump height logic
	elif Input.is_action_just_released(&"jump") and velocity.y < 0.0:
		fall()
	
	# Uncomment to enable
	# Note: Remember to disable the same logic in _unhandled_input
	# Hold jump logic
	#if Input.is_action_pressed(&"jump") and is_on_floor():
		#jump()
	
	# Process character movement
	super(delta)
