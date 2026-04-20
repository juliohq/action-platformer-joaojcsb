extends MarginContainer


const COUNT := 5
const BLUE_ORB := [
	preload("res://assets/ui/blue_orb/0.png"),
	preload("res://assets/ui/blue_orb/1.png"),
	preload("res://assets/ui/blue_orb/2.png"),
	preload("res://assets/ui/blue_orb/3.png"),
	preload("res://assets/ui/blue_orb/4.png"),
	preload("res://assets/ui/blue_orb/5.png"),
	preload("res://assets/ui/blue_orb/6.png"),
]
const RED_ORB := [
	preload("res://assets/ui/red_orb/0.png"),
	preload("res://assets/ui/red_orb/1.png"),
	preload("res://assets/ui/red_orb/2.png"),
	preload("res://assets/ui/red_orb/3.png"),
	preload("res://assets/ui/red_orb/4.png"),
	preload("res://assets/ui/red_orb/5.png"),
	preload("res://assets/ui/red_orb/6.png"),
]

@export var type := Globals.Orb.BLUE


func _ready() -> void:
	Events.orb_dropped.connect(update.unbind(1))
	
	update()


func update() -> void:
	var count := -1
	
	if type == Globals.Orb.BLUE:
		count = Globals.blue_orbs
	else:
		count = Globals.red_orbs
	
	%Orb.texture = [
		BLUE_ORB,
		RED_ORB,
	][type][COUNT - count]
	%Count.text = "%d/%d" % [count, COUNT]
