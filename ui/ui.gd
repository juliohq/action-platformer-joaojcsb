extends CanvasLayer


const PAUSE := preload("res://ui/pause.tscn")
const GAME_OVER := preload("res://ui/game_over.tscn")
const SKILL_TWO_PROMPTS := preload("res://ui/controls/skill_two_prompts.tscn")


func _ready() -> void:
	Events.chest_opened.connect(update)
	Events.skill_one_used.connect(update)
	Events.game_over.connect(_game_over)
	Events.orb_added.connect(_orb_added)
	
	update()
	show()


func update() -> void:
	if Globals.tutorial >= Globals.Tutorial.BASIC:
		%HealthBar.modulate = Color.WHITE
		%Coins.modulate = Color.WHITE
	else:
		%HealthBar.modulate = Color.TRANSPARENT
		%Coins.modulate = Color.TRANSPARENT
	
	if Globals.tutorial >= Globals.Tutorial.CHANGE_ORB:
		%OrbSelector.modulate = Color.WHITE
	else:
		%OrbSelector.modulate = Color.TRANSPARENT
	
	if Globals.tutorial >= Globals.Tutorial.SHOOT:
		%RedOrb.modulate = Color.WHITE
	else:
		%RedOrb.modulate = Color.TRANSPARENT
	
	if Globals.tutorial >= Globals.Tutorial.CHANGE_ORB:
		%BlueOrb.modulate = Color.WHITE
	else:
		%BlueOrb.modulate = Color.TRANSPARENT
	
	if Globals.tutorial >= Globals.Tutorial.SHOOT:
		%PowerA.modulate = Color.WHITE
	else:
		%PowerA.modulate = Color.TRANSPARENT
	
	if Globals.tutorial >= Globals.Tutorial.SKILL_TWO:
		%PowerB.modulate = Color.WHITE
	else:
		%PowerB.modulate = Color.TRANSPARENT


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(PAUSE.instantiate())
	elif event is InputEventKey and event.is_pressed():
		if event.physical_keycode == KEY_1:
			get_viewport().set_input_as_handled()
			var shop := preload("res://ui/shop.tscn").instantiate()
			add_child(shop)


func _game_over() -> void:
	add_child(GAME_OVER.instantiate())


func _orb_added() -> void:
	if Globals.tutorial != Globals.Tutorial.CHANGE_ORB:
		return
	
	if Globals.red_orbs >= Globals.FIRE_GRENADE_COST:
		Globals.tutorial = Globals.Tutorial.SKILL_TWO
		update()
		add_child(SKILL_TWO_PROMPTS.instantiate())
