extends CharacterBody2D


@export_range(1, 10, 1, "or_greater") var amount := 1
@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s²") var gravity := 980
@export_category("Nodes")
@export var collectible: Area2D
@export var visibility: VisibleOnScreenNotifier2D


func _ready() -> void:
	collectible.picked_up.connect(_picked_up)
	visibility.screen_exited.connect(_screen_exited)


func _physics_process(delta: float) -> void:
	# Gravity
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += gravity * delta
	
	# Movement
	move_and_slide()


func _picked_up() -> void:
	Globals.coins += 1
	Events.coins_changed.emit()
	queue_free()


func _screen_exited() -> void:
	if velocity.y > 0.0:
		queue_free()
