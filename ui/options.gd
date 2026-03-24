extends Control


@onready var master_bus := AudioServer.get_bus_index(&"Master")
@onready var music_bus := AudioServer.get_bus_index(&"Music")
@onready var sounds_bus := AudioServer.get_bus_index(&"Sounds")
## The control to be focused.
@export var focus_control: Control


func _ready() -> void:
	# Prepare languages
	var locales = TranslationServer.get_loaded_locales()
	
	for locale in locales:
		%Languages.add_item(TranslationServer.get_locale_name(locale))
	
	var index = locales.find(Globals.language)
	%Languages.select(index)
	
	# Prepare the rest of the menu
	push_warning("Difficulty mode read logic isn't implemented")
	%FullscreenValue.set_pressed_no_signal(get_window().mode == Window.MODE_FULLSCREEN)
	%GeneralVolume.value = AudioServer.get_bus_volume_linear(master_bus)
	%MusicVolume.value = AudioServer.get_bus_volume_linear(music_bus)
	%SoundsVolume.value = AudioServer.get_bus_volume_linear(sounds_bus)
	
	if is_instance_valid(focus_control):
		focus_control.grab_focus()


func _exit_tree() -> void:
	Globals.save_settings(Globals.SETTINGS_PATH)


## Handles the logic when the language is changed. Override to provide custom behavior.
func _language_changed(index: int) -> void:
	var locales = TranslationServer.get_loaded_locales()
	Globals.language = locales[index]
	TranslationServer.set_locale(Globals.language)


## Handles the logic when the difficulty mode is changed. Override to provide custom behavior.
func _difficulty_changed(_difficulty: int) -> void:
	push_warning("Difficulty logic not implemented!")


## Handles the logic when the fullscreen mode is toggled. Override to provide custom behavior.
func _fullscreen(toggled_on: bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED


## Handles the logic when the general volume is changed. Override to provide custom behavior.
func _general_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(master_bus, value)


## Handles the logic when the music volume is changed. Override to provide custom behavior.
func _music_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus, value)


## Handles the logic when the sounds volume is changed. Override to provide custom behavior.
func _sounds_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sounds_bus, value)


## Handles the logic when reset button is pressed. Override to provide custom behavior.
func _reset() -> void:
	pass


## Handles the logic when the accept button is pressed. Override to provide custom behavior.
func _back() -> void:
	queue_free()
