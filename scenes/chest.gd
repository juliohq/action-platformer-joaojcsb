extends Node2D


@export var animator: AnimationPlayer
@export var action: Area2D
@export var open_audio: AudioStreamPlayer
@export var slingshot_audio: AudioStreamPlayer


func _ready() -> void:
	if Globals.tutorial < Globals.Tutorial.SHOOT:
		action.used.connect(_used, CONNECT_ONE_SHOT)


func _used() -> void:
	open_audio.play()
	animator.play("OPEN")
	action.hide()
	await animator.animation_finished
	action.show()
	action.used.connect(get_slingshot, CONNECT_ONE_SHOT)


func get_slingshot() -> void:
	animator.play("GET_SLINGSHOT")
	action.hide()
	await animator.animation_finished
	# Slingshot audio
	slingshot_audio.play()
	
	# Update orbs
	Globals.red_orbs = Globals.RED_ORBS
	Globals.blue_orbs = Globals.BLUE_ORBS
	Events.orb_added.emit()
	
	Globals.tutorial = Globals.Tutorial.SHOOT
	Events.chest_opened.emit()
