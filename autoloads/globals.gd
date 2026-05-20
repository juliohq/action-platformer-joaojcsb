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
const RED_ORBS := 5
## How many blue orbs the player has.
const BLUE_ORBS := 5
## How many orbs a life costs.
const LIFE_COST := 1
## How many orbs the power will cost.
const FIRE_GRENADE_COST := 2
## How many orbs the power will cost.
const GIANT_ICE_ORB_COST := 2

## The current language code.
var language := "en"

## The player health (HP).
var player_health := PLAYER_HEALTH
## The max player health (HP).
var max_player_health := PLAYER_HEALTH
## The count of coins the player has.
var coins := 0
## The current orb selected.
var orb := ORB
## How many red orbs the player has.
var red_orbs := RED_ORBS
## How many red orbs the player has at max.
var max_red_orbs := RED_ORBS
## How many blue orbs the player has.
var blue_orbs := BLUE_ORBS
## How many blue orbs the player has at max.
var max_blue_orbs := BLUE_ORBS

# Tutorial toggles
var enable_health := true
var enable_coins := true
var enable_orbs := true


func _ready() -> void:
	randomize()
	load_settings(SETTINGS_PATH)
	set_process_unhandled_input(OS.is_debug_build())
	reset()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		get_tree().quit()


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
	player_health = PLAYER_HEALTH
	max_player_health = PLAYER_HEALTH
	coins = 0
	orb = ORB
	blue_orbs = BLUE_ORBS
	max_blue_orbs = BLUE_ORBS
	red_orbs = RED_ORBS
	max_red_orbs = RED_ORBS
