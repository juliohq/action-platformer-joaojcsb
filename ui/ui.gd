extends CanvasLayer


@export var show_health_bar := true
@export var health_bar: Control
@export var show_coins := true
@export var coins: Control
@export var show_orb_selector := true
@export var orb_selector: Control
@export var show_red_orb := true
@export var red_orb: Control
@export var show_blue_orb := true
@export var blue_orb: Control
@export var show_power_a := true
@export var power_a: Control
@export var show_power_b := true
@export var power_b: Control


func _ready() -> void:
	Events.game_over.connect(_game_over)
	
	if show_health_bar:
		health_bar.modulate = Color.WHITE
	else:
		health_bar.modulate = Color.TRANSPARENT
	
	if show_coins:
		coins.modulate = Color.WHITE
	else:
		coins.modulate = Color.TRANSPARENT
	
	if show_orb_selector:
		orb_selector.modulate = Color.WHITE
	else:
		orb_selector.modulate = Color.TRANSPARENT
	
	if show_red_orb:
		red_orb.modulate = Color.WHITE
	else:
		red_orb.modulate = Color.TRANSPARENT
	
	if show_blue_orb:
		blue_orb.modulate = Color.WHITE
	else:
		blue_orb.modulate = Color.TRANSPARENT
	
	if show_power_a:
		power_a.modulate = Color.WHITE
	else:
		power_a.modulate = Color.TRANSPARENT
	
	if show_power_b:
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
