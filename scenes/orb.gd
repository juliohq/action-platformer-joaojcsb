extends CharacterBody2D


func _physics_process(delta: float) -> void:
	if is_on_floor():
		# Bounce
		velocity.y = -absf(velocity.y)
	else:
		# Gravity
		velocity = Vector2.DOWN * delta
	
	# Movement
	move_and_slide()
