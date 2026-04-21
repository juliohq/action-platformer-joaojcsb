extends CharacterBody2D


@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s²") var gravity := 980
@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s") var bounce := 300
@export_category("Nodes")
@export var vanish: Timer
@export var collectible: Area2D


func _ready() -> void:
	vanish.timeout.connect(queue_free)
	collectible.picked_up.connect(_picked_up)


func _physics_process(delta: float) -> void:
	if is_on_floor():
		# Bounce
		velocity.y = -bounce
	else:
		# Gravity
		velocity.y += gravity * delta
	
	# Movement
	move_and_slide()


func _picked_up() -> void:
	queue_free()
