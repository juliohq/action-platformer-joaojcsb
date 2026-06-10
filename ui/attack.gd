extends MarginContainer


const FIREBALL := preload("res://assets/sprites/fireball.tres")
const FIRE_GRENADE := preload("res://assets/sprites/fire_grenade.tres")
const FREEZE_TOUCH := preload("res://assets/sprites/freeze_touch.tres")
const GIANT_ICE_ORB := preload("res://assets/sprites/giant_ice_orb.tres")

@export var attack := Globals.Attack.A


func _ready() -> void:
	Events.orb_changed.connect(update)
	
	if attack == Globals.Attack.A:
		%CooldownBar.modulate.a = 0.0
	else:
		Events.strong_attack_used.connect(_attack_used)
		Events.strong_attack_ready.connect(_attack_ready)
		Events.strong_attack_cooldown.connect(%CooldownBar.update)
	
	update()


func update() -> void:
	if attack == Globals.Attack.A:
		%Level.text = "Lv 1"
		
		if Globals.orb == Globals.Orb.RED:
			%Attack.texture = FIREBALL
			update_cost(1)
		else:
			%Attack.texture = FREEZE_TOUCH
			update_cost(1)
	else:
		%Level.text = "Lv 2"
		
		if Globals.orb == Globals.Orb.RED:
			%Attack.texture = FIRE_GRENADE
			update_cost(Globals.FIRE_GRENADE_COST)
		else:
			%Attack.texture = GIANT_ICE_ORB
			update_cost(Globals.GIANT_ICE_ORB_COST)


func _attack_used() -> void:
	%Attack.material = preload("res://shaders/grayscale.tres")


func _attack_ready() -> void:
	%Attack.material = null


func update_cost(cost: int) -> void:
	for child: Node in %Cost.get_children():
		child.queue_free()
	
	for i in cost:
		var orb := TextureRect.new()
		
		if Globals.orb == Globals.Orb.RED:
			orb.texture = preload("res://assets/ui/red_orb/0.png")
		else:
			orb.texture = preload("res://assets/ui/blue_orb/0.png")
		
		%Cost.add_child(orb)
