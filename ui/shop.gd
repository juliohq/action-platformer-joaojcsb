extends Control


const ITEMS := [
	{
		"id": Globals.Upgrade.HEALTH,
		"name": "HP +1",
		"description": "Aumenta seu HP em 1 (upgrade permanente)",
		"cost": 20,
		"limit": 6,
	},
	{
		"id": Globals.Upgrade.EXTRA_FIRE_ORB,
		"name": "Extra Fire Orb +1",
		"description": "Aumenta suas orbs de fogo em 1 (upgrade permanente)",
		"cost": 20,
		"limit": 10,
	},
	{
		"id": Globals.Upgrade.EXTRA_ICE_ORB,
		"name": "Extra Ice Orb +1",
		"description": "Aumenta suas orbs de gelo em 1 (upgrade permanente)",
		"cost": 20,
		"limit": 10,
	},
	{
		"id": Globals.Upgrade.IMMUNITY,
		"name": "Imunidade",
		"description": "Voce fica imune por 8 segundos (upgrade temporario)",
		"cost": 30,
	},
	{
		"id": Globals.Upgrade.PARALYZE,
		"name": "Paralise",
		"description": "Paraliza os inimigos por 20 segundos (upgrade temporario)",
		"cost": 40,
	},
]
const SHOP_OPEN := preload("res://assets/audio/shop_open.wav")
const NOT_ENOUGH_COINS := preload("res://assets/audio/not_enough_coins.wav")
const EXTRA_ORB := preload("res://assets/audio/extra_orb.wav")
const TEMPORARY_UPGRADE := preload("res://assets/audio/temporary_upgrade.wav")


func _ready() -> void:
	%Exit.pressed.connect(_exit)
	
	get_tree().paused = true
	AudioManager.play(SHOP_OPEN, 1.0, &"Sounds")
	
	# Spawn shop items
	for item: Dictionary in ITEMS:
		var shop_item := preload("res://ui/shop_item.tscn").instantiate()
		shop_item.item = item
		shop_item.purchased.connect(_purchased)
		%Items.add_child(shop_item)
	
	update()


func _exit_tree() -> void:
	get_tree().paused = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		queue_free()
	elif OS.is_debug_build():
		if event.is_action_pressed(&"cheat_coins"):
			Globals.coins += 1000
			Events.coins_changed.emit()
			update()


func _exit() -> void:
	queue_free()


func _purchased(item: Dictionary) -> void:
	if Globals.coins < item.cost:
		AudioManager.play(NOT_ENOUGH_COINS, 1.0, &"Sounds")
		return
	
	# Limit
	match item.id:
		Globals.Upgrade.HEALTH:
			if false:
				return
		Globals.Upgrade.EXTRA_FIRE_ORB:
			if false:
				return
		Globals.Upgrade.EXTRA_ICE_ORB:
			if false:
				return
	
	print(item)
	
	# Cost
	Globals.coins -= item.cost
	Events.coins_changed.emit()
	update()
	
	# Audio
	match item.id:
		Globals.Upgrade.EXTRA_FIRE_ORB:
			_play_orb_audio()
		Globals.Upgrade.EXTRA_ICE_ORB:
			_play_orb_audio()
		_:
			if "limit" not in item:
				AudioManager.play(TEMPORARY_UPGRADE, 1.0, &"Sounds")
	
	# Effect
	match item.id:
		Globals.Upgrade.HEALTH:
			# Update right now
			if Globals.player_health >= Globals.default_player_health:
				Globals.max_player_health += 1
			
			Globals.player_health += 1
			
			# Permanent change
			Globals.default_player_health += 1
			
			Events.player_health_changed.emit()
		Globals.Upgrade.EXTRA_FIRE_ORB:
			# Update right now
			if Globals.red_orbs >= Globals.default_red_orbs:
				Globals.max_red_orbs += 1
			
			Globals.red_orbs += 1
			
			# Permanent change
			Globals.default_red_orbs += 1
			
			Events.orb_added.emit()
		Globals.Upgrade.EXTRA_ICE_ORB:
			# Update right now
			if Globals.blue_orbs >= Globals.default_blue_orbs:
				Globals.max_blue_orbs += 1
			
			Globals.blue_orbs += 1
			
			# Permanent change
			Globals.default_blue_orbs += 1
			
			Events.orb_added.emit()
		Globals.Upgrade.IMMUNITY:
			Events.player_invincible.emit(8.0)
		Globals.Upgrade.PARALYZE:
			Globals.enemy_paralyze = 20.0


func update() -> void:
	%Coins.text = "Coins: %d" % Globals.coins


func _play_orb_audio() -> void:
	AudioManager.play(EXTRA_ORB, 1.0, &"Sounds")
