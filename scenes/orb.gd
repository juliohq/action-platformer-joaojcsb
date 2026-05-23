extends CharacterBody2D


@export var orb := Globals.Orb.RED
@export_range(0.1, 10.0, 0.1, "or_greater", "suffix:px/s²") var gravity := 980
@export var auto_vanish := true
@export_category("Nodes")
@export var vanish: Timer
@export var collectible: Area2D


func _ready() -> void:
	if is_instance_valid(vanish) and auto_vanish:
		vanish.timeout.connect(queue_free)
	
	collectible.picked_up.connect(_picked_up)


func _physics_process(delta: float) -> void:
	# Gravity
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y += gravity * delta
	
	# Movement
	move_and_slide()


func _picked_up() -> void:
	if orb == Globals.Orb.RED:
		Globals.red_orbs += 1
		Globals.max_red_orbs += 1
	else:
		Globals.blue_orbs += 1
		Globals.max_blue_orbs += 1
	
	Events.orb_added.emit()
	queue_free()
