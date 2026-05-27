extends MarginContainer


const LABEL_SETTINGS_NORMAL := preload("res://ui/theme/label_settings.tres")
const LABEL_SETTINGS_GREEN := preload("res://ui/theme/label_settings_green.tres")


func _ready() -> void:
	Events.player_health_changed.connect(update)
	
	update()


func update() -> void:
	%Health.max_value = Globals.max_player_health
	%Health.value = Globals.player_health
	%Count.text = str(Globals.player_health)
	%MaxCount.text = str(Globals.max_player_health)
	
	if Globals.max_player_health > Globals.default_player_health:
		%MaxCount.label_settings = LABEL_SETTINGS_GREEN
	else:
		%MaxCount.label_settings = LABEL_SETTINGS_NORMAL
