extends Control


const ITEMS := [
	{
		"id": Globals.Upgrade.HEALTH,
		"name": "SHOP_HEALTH",
		"description": "SHOP_HEALTH_DESCRIPTION",
		"cost": 20,
		"limit": 6,
	},
	{
		"id": Globals.Upgrade.EXTRA_FIRE_ORB,
		"name": "SHOP_EXTRA_FIRE_ORB",
		"description": "SHOP_EXTRA_FIRE_ORB_DESCRIPTION",
		"cost": 20,
		"limit": 10,
	},
	{
		"id": Globals.Upgrade.EXTRA_ICE_ORB,
		"name": "SHOP_EXTRA_ICE_ORB",
		"description": "SHOP_EXTRA_ICE_ORB_DESCRIPTION",
		"cost": 20,
		"limit": 10,
	},
	{
		"id": Globals.Upgrade.IMMUNITY,
		"name": "SHOP_IMMUNITY",
		"description": "SHOP_IMMUNITY_DESCRIPTION",
		"cost": 30,
	},
	{
		"id": Globals.Upgrade.PARALYZE,
		"name": "SHOP_PARALYZE",
		"description": "SHOP_PARALYZE_DESCRIPTION",
		"cost": 40,
	},
]
const SHOP_OPEN := preload("res://assets/audio/shop_open.wav")
const NOT_ENOUGH_COINS := preload("res://assets/audio/not_enough_coins.wav")
const EXTRA_ORB := preload("res://assets/audio/extra_orb.wav")
const TEMPORARY_UPGRADE := preload("res://assets/audio/temporary_upgrade.wav")

const ANIMATION_DURATION := 0.4


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
	
	var control: Control = %Items.get_child(0)
	control.grab_focus()
	
	update()
	
	# Animation
	%Background.modulate = Color.TRANSPARENT
	%Margin.offset_transform_position_ratio = Vector2(0, -1)
	
	var tween := Tweens.tween_empty(self, Tween.EASE_OUT,
			Tween.TRANS_QUAD).set_parallel()
	tween.tween_property(%Background, "modulate", Color.WHITE,
			ANIMATION_DURATION)
	tween.tween_property(%Margin, "offset_transform_position_ratio", Vector2(),
			ANIMATION_DURATION)


func _exit_tree() -> void:
	get_tree().paused = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_exit()
	elif OS.is_debug_build():
		if event.is_action_pressed(&"cheat_coins"):
			Globals.coins += 1000
			Events.coins_changed.emit()
			update()


func _exit() -> void:
	%Items.process_mode = Node.PROCESS_MODE_DISABLED
	%Exit.process_mode = Node.PROCESS_MODE_DISABLED
	
	# Animation
	var tween := Tweens.tween_empty(self, Tween.EASE_OUT,
			Tween.TRANS_QUAD).set_parallel()
	tween.tween_property(%Background, "modulate", Color.TRANSPARENT,
			ANIMATION_DURATION)
	tween.tween_property(%Margin, "offset_transform_position_ratio",
			Vector2(0, -1), ANIMATION_DURATION)
	tween.chain().tween_callback(queue_free)


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
		Globals.Upgrade.IMMUNITY:
			if Globals.power_immunity >= Globals.MAX_POWER_IMMUNITY:
				return
		Globals.Upgrade.PARALYZE:
			if Globals.power_paralyze >= Globals.MAX_POWER_PARALYZE:
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
			Globals.default_red_orbs += 1
			Globals.max_red_orbs += 1
			Globals.red_orbs += 1
			Events.orb_added.emit()
		Globals.Upgrade.EXTRA_ICE_ORB:
			Globals.default_blue_orbs += 1
			Globals.max_blue_orbs += 1
			Globals.blue_orbs += 1
			Events.orb_added.emit()
		Globals.Upgrade.IMMUNITY:
			Globals.power_immunity += 1
			Events.power_purchased.emit()
		Globals.Upgrade.PARALYZE:
			Globals.power_paralyze += 1
			Events.power_purchased.emit()


func update() -> void:
	%Coins.text = "Coins: %d" % Globals.coins


func _play_orb_audio() -> void:
	AudioManager.play(EXTRA_ORB, 1.0, &"Sounds")
