extends Node


enum Orb {
	RED,
	BLUE,
}

enum Attack {
	# Level 1 attack
	A,
	# Level 2 attack
	B,
}

enum Tutorial {
	# Health and coins only
	BASIC,
	# Knows how to shoot skill level 1
	SHOOT,
	# Knows how to change orbs
	CHANGE_ORB,
	# Knows how to shoot skill level 2
	SKILL_TWO,
	# Knows how to heal
	HEAL,
}

enum Upgrade {
	HEALTH,
	EXTRA_FIRE_ORB,
	EXTRA_ICE_ORB,
	IMMUNITY,
	PARALYZE,
}

## The default path for the settings file.
const SETTINGS_PATH := "user://settings.dat"
## The default path for the save file.
const SAVE_PATH := "user://save.dat"
## The version of the same file. (for backward compatibility)
const SAVE_VERSION := 1

## The player health (HP).
const PLAYER_HEALTH := 2
## The current orb selected.
const ORB := Orb.RED
## How many red orbs the player has.
const RED_ORBS := 3
## How many blue orbs the player has.
const BLUE_ORBS := 3
## How many orbs a life costs.
const LIFE_COST := 1
## How many orbs the attack will cost.
const FIRE_GRENADE_COST := 2
## How many orbs the attack will cost.
const GIANT_ICE_ORB_COST := 2

## The current language code.
var language := "en"

## The current player.
var player: CharacterBody2D

## The default player health.
var default_player_health := PLAYER_HEALTH
## The player health (HP).
var player_health := default_player_health
## The max player health (HP).
var max_player_health := default_player_health
## The count of coins the player has.
var coins := 0
## The current orb selected.
var orb := ORB
## The default red orbs.
var default_red_orbs := RED_ORBS
## How many red orbs the player has.
var red_orbs := default_red_orbs
## How many red orbs the player has at max.
var max_red_orbs := default_red_orbs
## The default blue orbs.
var default_blue_orbs := BLUE_ORBS
## How many blue orbs the player has.
var blue_orbs := default_blue_orbs
## How many blue orbs the player has at max.
var max_blue_orbs := default_blue_orbs
## How long enemies will be paralyzed.
var enemy_paralyze := 0.0

# Tutorial toggles
var tutorial := Tutorial.HEAL


func _ready() -> void:
	randomize()
	load_settings(SETTINGS_PATH)
	set_process_unhandled_input(OS.is_debug_build())
	reset()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_tree().quit()
	elif OS.is_debug_build():
		if event.is_action_pressed(&"cheat_coins"):
			coins += 1000
			Events.coins_changed.emit()


## Saves the game state to the given file path.
func save_game(file_path := SAVE_PATH) -> void:
	var f := FileAccess.open(file_path, FileAccess.WRITE)
	var err := f.get_error()
	
	if err == OK:
		f.store_var(SAVE_VERSION)
		var scene_path = get_tree().current_scene.scene_file_path
		assert(scene_path, "Current scene path is empty")
		f.store_var(scene_path)
		
		push_warning("Save game logic not implemented!")
	else:
		push_error("Failed to save file %s (error %d)." % [file_path, err])


## Loads the game state from the given file path.
func load_game(file_path := SAVE_PATH) -> void:
	if FileAccess.file_exists(file_path):
		var f := FileAccess.open(file_path, FileAccess.READ)
		var err := f.get_error()
		
		if err == OK:
			var version = f.get_var()
			assert(typeof(version) == TYPE_INT, "Failed to load save file version (%s)" % file_path)
			var scene_path = f.get_var()
			assert(typeof(scene_path) == TYPE_STRING, "Failed to load scene from save file (%s)" % file_path)
			
			push_warning("Load game logic not implemented!")
			
			get_tree().change_scene_to_file(scene_path)
		else:
			push_error("Failed to load file %s (error %d)." % [file_path, err])
	else:
		push_error("File %s does not exist" % file_path)


## Saves the game settings.
func save_settings(file_path: String) -> void:
	var f := FileAccess.open(file_path, FileAccess.WRITE)
	var err := f.get_error()
	
	if err == OK:
		# Save language
		f.store_var(language)
		
		# Save window fullscreen mode
		f.store_var(get_window().mode == Window.MODE_FULLSCREEN)
		
		# Save audio buses volumes
		var buses = []
		
		for bus in AudioServer.bus_count:
			buses.append(AudioServer.get_bus_volume_linear(bus))
		
		f.store_var(buses)
		
		# Save input map
		#var input_map := {}
		#
		#for action: StringName in InputMap.get_actions():
			#if action.begins_with("ui_"):
				#continue
			#
			#var events = InputMap.action_get_events(action)
			#input_map[action] = var_to_str(events)
		#
		#f.store_var(input_map)
	else:
		push_error("Failed to save file to %s (error %d)" % [file_path, err])


## Loads the game settings.
func load_settings(file_path: String) -> void:
	if FileAccess.file_exists(file_path):
		var f := FileAccess.open(file_path, FileAccess.READ)
		var err := f.get_error()
		
		if err == OK:
			# Read language
			language = f.get_var()
			TranslationServer.set_locale(language)
			
			# Read window fullscreen mode
			get_window().mode = Window.MODE_FULLSCREEN if f.get_var() else Window.MODE_WINDOWED
			
			# Read audio buses volumes
			var bus := 0
			
			for volume: float in f.get_var():
				AudioServer.set_bus_volume_linear(bus, volume)
				bus += 1
			
			# Read input map
			#var input_map: Dictionary = f.get_var()
			#
			#for action: StringName in input_map:
				#InputMap.action_erase_events(action)
				#
				#for event: InputEvent in str_to_var(input_map[action]):
					#InputMap.action_add_event(action, event)
		else:
			push_error("Failed to load file from %s (error %d)" % [file_path, err])


func reset() -> void:
	player_health = default_player_health
	max_player_health = default_player_health
	coins = 0
	orb = ORB
	red_orbs = default_red_orbs
	max_red_orbs = default_red_orbs
	blue_orbs = default_blue_orbs
	max_blue_orbs = default_blue_orbs


func _process(delta: float) -> void:
	if enemy_paralyze > 0.0:
		enemy_paralyze -= delta
		
		if enemy_paralyze < 0.0:
			enemy_paralyze = 0.0
