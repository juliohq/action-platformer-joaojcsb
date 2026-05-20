extends CanvasLayer


func _ready() -> void:
	Events.game_over.connect(_game_over)
	
	if Globals.enable_health:
		%HealthBar.modulate = Color.WHITE
	else:
		%HealthBar.modulate = Color.TRANSPARENT
	
	if Globals.enable_coins:
		%Coins.modulate = Color.WHITE
	else:
		%Coins.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		%OrbSelector.modulate = Color.WHITE
	else:
		%OrbSelector.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		%RedOrb.modulate = Color.WHITE
	else:
		%RedOrb.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		%BlueOrb.modulate = Color.WHITE
	else:
		%BlueOrb.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		%PowerA.modulate = Color.WHITE
	else:
		%PowerA.modulate = Color.TRANSPARENT
	
	if Globals.enable_orbs:
		%PowerB.modulate = Color.WHITE
	else:
		%PowerB.modulate = Color.TRANSPARENT
	
	show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(preload("res://ui/pause.tscn").instantiate())


func _game_over() -> void:
	add_child(preload("res://ui/game_over.tscn").instantiate())
