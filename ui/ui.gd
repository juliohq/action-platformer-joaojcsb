extends CanvasLayer


func _ready() -> void:
	Events.chest_opened.connect(update)
	Events.game_over.connect(_game_over)
	
	update()
	show()


func update() -> void:
	if Globals.enable_health:
		%HealthBar.modulate = Color.WHITE
	else:
		%HealthBar.modulate = Color.TRANSPARENT
	
	if Globals.enable_coins:
		%Coins.modulate = Color.WHITE
	else:
		%Coins.modulate = Color.TRANSPARENT
	
	if Globals.orb_level == Globals.OrbLevel.NONE:
		%OrbSelector.modulate = Color.TRANSPARENT
	else:
		%OrbSelector.modulate = Color.WHITE
	
	if Globals.orb_level == Globals.OrbLevel.NONE:
		%RedOrb.modulate = Color.TRANSPARENT
	else:
		%RedOrb.modulate = Color.WHITE
	
	if Globals.orb_level != Globals.OrbLevel.ALL:
		%BlueOrb.modulate = Color.TRANSPARENT
	else:
		%BlueOrb.modulate = Color.WHITE
	
	if Globals.orb_level == Globals.OrbLevel.NONE:
		%PowerA.modulate = Color.TRANSPARENT
	else:
		%PowerA.modulate = Color.WHITE
	
	if Globals.orb_level != Globals.OrbLevel.ALL:
		%PowerB.modulate = Color.TRANSPARENT
	else:
		%PowerB.modulate = Color.WHITE


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(preload("res://ui/pause.tscn").instantiate())


func _game_over() -> void:
	add_child(preload("res://ui/game_over.tscn").instantiate())
