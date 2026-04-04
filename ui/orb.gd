extends MarginContainer


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


func _ready() -> void:
	update()


func update() -> void:
	var count := get_index()
	%Orb.texture = [
		BLUE_ORB,
		RED_ORB,
	][count][0]
	%Count.text = "%d/%d" % [count, 5]
