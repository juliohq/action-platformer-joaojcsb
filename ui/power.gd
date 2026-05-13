extends MarginContainer


const FIREBALL := preload("res://assets/sprites/fireball.tres")
const FIRE_GRENADE := preload("res://assets/sprites/fire_grenade.tres")
const FREEZE_TOUCH := preload("res://assets/sprites/freeze_touch.tres")
const GIANT_ICE_ORB := preload("res://assets/sprites/giant_ice_orb.tres")

@export var attack := Globals.Attack.A


func _ready() -> void:
	Events.orb_changed.connect(update)
	
	if attack == Globals.Attack.A:
		%CooldownBar.hide()
	else:
		Events.strong_power_used.connect(_power_used)
		Events.strong_power_ready.connect(_power_ready)
		Events.strong_power_cooldown.connect(%CooldownBar.update)
	
	update()


func update() -> void:
	if attack == Globals.Attack.A:
		%Level.text = "Lv 1"
		
		if Globals.orb == Globals.Orb.RED:
			%Power.texture = FIREBALL
		else:
			%Power.texture = FREEZE_TOUCH
	else:
		%Level.text = "Lv 2"
		
		if Globals.orb == Globals.Orb.RED:
			%Power.texture = FIRE_GRENADE
		else:
			%Power.texture = GIANT_ICE_ORB


func _power_used() -> void:
	%Power.material = preload("res://shaders/grayscale.tres")


func _power_ready() -> void:
	%Power.material = null
