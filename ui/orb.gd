extends MarginContainer


const LABEL_SETTINGS_NORMAL := preload("res://ui/theme/label_settings.tres")
const LABEL_SETTINGS_GREEN := preload("res://ui/theme/label_settings_green.tres")

const RED_ORB_FULL := preload("res://assets/ui/red_orb/0.png")
const RED_ORB_EMPTY := preload("res://assets/ui/red_orb/6.png")
const BLUE_ORB_FULL := preload("res://assets/ui/blue_orb/0.png")
const BLUE_ORB_EMPTY := preload("res://assets/ui/blue_orb/6.png")

@export var type := Globals.Orb.RED


func _ready() -> void:
	Events.orb_added.connect(update)
	Events.orb_dropped.connect(update.unbind(1))
	Events.orb_consumed.connect(update)
	
	update()


func update() -> void:
	var value := -1
	var max_value := -1
	var default := -1
	
	if type == Globals.Orb.RED:
		value = Globals.red_orbs
		max_value = Globals.max_red_orbs
		default = Globals.RED_ORBS
	else:
		value = Globals.blue_orbs
		max_value = Globals.max_blue_orbs
		default = Globals.BLUE_ORBS
	
	%Orb.texture_under = [
		RED_ORB_EMPTY,
		BLUE_ORB_EMPTY,
	][type]
	%Orb.texture_progress = [
		RED_ORB_FULL,
		BLUE_ORB_FULL,
	][type]
	%Orb.max_value = max_value
	%Orb.value = value
	%Count.text = str(value)
	%MaxCount.text = str(max_value)
	
	if max_value > default:
		%MaxCount.label_settings = LABEL_SETTINGS_GREEN
	else:
		%MaxCount.label_settings = LABEL_SETTINGS_NORMAL
