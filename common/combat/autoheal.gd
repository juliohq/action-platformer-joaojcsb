extends Node


## The character to be automatically healed.
@export var target: Node: set = set_target
## How long will it take to start healing.
@export_range(0.01, 100.0, 0.01, "suffix:s") var interval := 5.0
## How long will it take to heal each step.
@export_range(0.01, 100.0, 0.01, "suffix:s") var cooldown := 1.0
## How much the character will be healed on each step.
@export_range(1, 1000, 1, "suffix:HP") var heal_amount := 1

var _interval := 0.0
var _cooldown := 0.0


func _ready() -> void:
	set_process(false)


func _damaged() -> void:
	_interval = interval
	set_process(true)


func _process(delta: float) -> void:
	if _interval > 0.0:
		_interval -= delta
	elif _cooldown > 0.0:
		_cooldown -= delta
	elif target.health < target.max_health:
		_cooldown = cooldown
		target.heal(heal_amount)
	else:
		set_process(false)


func set_target(node: Node) -> void:
	if is_instance_valid(target):
		target.damaged.disconnect(_damaged)
	
	assert("health" in node, "target has no health property")
	assert("max_health" in node, "target has no max_health property")
	assert(node.has_method(&"heal"), "target has no heal method")
	assert(node.has_signal(&"damaged"), "target has no damaged signal")
	target = node
	
	target.damaged.connect(_damaged)
