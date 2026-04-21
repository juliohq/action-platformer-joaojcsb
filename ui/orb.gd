extends MarginContainer


const COUNT := 5
const RED_ORB := [
	preload("res://assets/ui/red_orb/0.png"),
	preload("res://assets/ui/red_orb/1.png"),
	preload("res://assets/ui/red_orb/2.png"),
	preload("res://assets/ui/red_orb/3.png"),
	preload("res://assets/ui/red_orb/4.png"),
	preload("res://assets/ui/red_orb/5.png"),
	preload("res://assets/ui/red_orb/6.png"),
]
const BLUE_ORB := [
	preload("res://assets/ui/blue_orb/0.png"),
	preload("res://assets/ui/blue_orb/1.png"),
	preload("res://assets/ui/blue_orb/2.png"),
	preload("res://assets/ui/blue_orb/3.png"),
	preload("res://assets/ui/blue_orb/4.png"),
	preload("res://assets/ui/blue_orb/5.png"),
	preload("res://assets/ui/blue_orb/6.png"),
]

@export var type := Globals.Orb.RED


func _ready() -> void:
	Events.orb_added.connect(update)
	Events.orb_dropped.connect(update.unbind(1))
	
	update()


func update() -> void:
	var count := -1
	
	if type == Globals.Orb.RED:
		count = Globals.red_orbs
	else:
		count = Globals.blue_orbs
	
	%Orb.texture = [
		RED_ORB,
		BLUE_ORB,
	][type][COUNT - count]
	%Count.text = "%d/%d" % [count, COUNT]
