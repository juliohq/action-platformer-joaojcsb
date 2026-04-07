extends MarginContainer


enum Orb {
	BLUE,
	RED,
}

const HEALTH_BAR := [
	preload("res://assets/ui/health_bar/0.png"),
	#preload("res://assets/ui/health_bar/1.png"),
	#preload("res://assets/ui/health_bar/2.png"),
	preload("res://assets/ui/health_bar/3.png"),
	#preload("res://assets/ui/health_bar/4.png"),
	#preload("res://assets/ui/health_bar/5.png"),
	preload("res://assets/ui/health_bar/6.png"),
]


func _ready() -> void:
	Events.player_health_changed.connect(update)
	
	update()


func update() -> void:
	var count := Globals.player_health
	var texture_count := HEALTH_BAR.size()
	%Health.texture = HEALTH_BAR[texture_count - count - 1]
	%Count.text = "%d/%d" % [count, Globals.PLAYER_HEALTH]
