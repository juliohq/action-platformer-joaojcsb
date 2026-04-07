extends CharacterBody2D


@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s²") var gravity := 980
@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s") var bounce := 360


func _physics_process(delta: float) -> void:
	if is_on_floor():
		# Bounce
		velocity.y = -bounce
	else:
		# Gravity
		velocity.y += gravity * delta
	
	# Movement
	move_and_slide()
