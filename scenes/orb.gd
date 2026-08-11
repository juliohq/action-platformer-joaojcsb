extends RigidBody2D


const HORIZONTAL_IMPULSE := 100
const VERTICAL_IMPULSE := 300

@export var orb := Globals.Orb.RED
@export var auto_vanish := true
@export_category("Nodes")
@export var vanish: Timer
@export var collectible: Area2D


func _ready() -> void:
	if is_instance_valid(vanish) and auto_vanish:
		vanish.timeout.connect(queue_free)
	
	collectible.picked_up.connect(_picked_up)
	
	apply_impulse(Vector2(Math.random_sign() * HORIZONTAL_IMPULSE,
			-VERTICAL_IMPULSE))


func _picked_up() -> void:
	if orb == Globals.Orb.RED:
		if Globals.red_orbs >= Globals.default_red_orbs:
			Globals.max_red_orbs += 1
		else:
			Globals.red_orbs += 1
	elif Globals.blue_orbs >= Globals.default_blue_orbs:
		Globals.max_blue_orbs += 1
	else:
		Globals.blue_orbs += 1
	
	Events.orb_added.emit()
	queue_free()
