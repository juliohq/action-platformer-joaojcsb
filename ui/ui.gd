extends CanvasLayer


@export var health_bar: Control
@export var coins: Control
@export var orb_selector: Control
@export var red_orb: Control
@export var blue_orb: Control
@export var power_a: Control
@export var power_b: Control


func _ready() -> void:
	Events.game_over.connect(_game_over)
	
	if Globals.enable_health:
		health_bar.modulate = Color.WHITE
	else:
		health_bar.modulate = Color.TRANSPARENT
	
	if Globals.enable_coins:
		coins.modulate = Color.WHITE
	else:
		coins.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		orb_selector.modulate = Color.WHITE
	else:
		orb_selector.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		red_orb.modulate = Color.WHITE
	else:
		red_orb.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		blue_orb.modulate = Color.WHITE
	else:
		blue_orb.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		power_a.modulate = Color.WHITE
	else:
		power_a.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		power_b.modulate = Color.WHITE
	else:
		power_b.modulate = Color.TRANSPARENT
	
	show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(preload("res://ui/pause.tscn").instantiate())


func _game_over() -> void:
	add_child(preload("res://ui/game_over.tscn").instantiate())
