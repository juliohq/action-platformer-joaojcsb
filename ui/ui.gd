extends CanvasLayer


const PAUSE := preload("res://ui/pause.tscn")
const GAME_OVER := preload("res://ui/game_over.tscn")
const SKILL_TWO_PROMPTS := preload("res://ui/controls/skill_two_prompts.tscn")
const SHOP := preload("res://ui/shop.tscn")

@export var level_indicator := false
@export_range(0, 10, 1, "or_greater") var level := 0
@export_range(1, 10, 1, "or_greater") var map := 1


func _ready() -> void:
	Events.chest_opened.connect(update)
	Events.skill_one_used.connect(update)
	Events.game_over.connect(_game_over)
	Events.orb_added.connect(_orb_added)
	Events.shop_entered.connect(_shop_entered)
	
	update()
	show()
	
	# Level indicator
	if level_indicator:
		%Animator.play("LEVEL")
		await %Animator.animation_finished
		%Animator.play_backwards("LEVEL")
		%Animator.seek(0.5)


func update() -> void:
	%Level.text = "%d-%d" % [level, map]
	
	handle_tutorial(%HealthBar, Globals.Tutorial.BASIC)
	handle_tutorial(%Coins, Globals.Tutorial.BASIC)
	handle_tutorial(%OrbSelector, Globals.Tutorial.CHANGE_ORB)
	handle_tutorial(%RedOrb, Globals.Tutorial.SHOOT)
	handle_tutorial(%BlueOrb, Globals.Tutorial.CHANGE_ORB)
	handle_tutorial(%AttackA, Globals.Tutorial.SHOOT)
	handle_tutorial(%AttackB, Globals.Tutorial.SKILL_TWO)


func handle_tutorial(control: Control, tutorial: Globals.Tutorial) -> void:
	if Globals.tutorial >= tutorial:
		control.modulate = Color.WHITE
	else:
		control.modulate = Color.TRANSPARENT


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_viewport().set_input_as_handled()
		add_child(PAUSE.instantiate())
	elif event is InputEventKey and event.is_pressed():
		if event.physical_keycode == KEY_TAB:
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


func _shop_entered() -> void:
	add_child(SHOP.instantiate())
