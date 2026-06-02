extends Node2D


@export var animator: AnimationPlayer
@export var player_detector: Area2D
@export var open_audio: AudioStreamPlayer
@export var slingshot_audio: AudioStreamPlayer


func _ready() -> void:
	if Globals.tutorial < Globals.Tutorial.SHOOT:
		player_detector.body_entered.connect(_player_entered, CONNECT_ONE_SHOT)


func _player_entered(_body: Node2D) -> void:
	animator.play("OPEN")
	open_audio.play()
	await animator.animation_finished
	
	# Slingshot audio
	slingshot_audio.play()
	
	# Update orbs
	Globals.red_orbs = Globals.RED_ORBS
	Globals.blue_orbs = Globals.BLUE_ORBS
	Events.orb_added.emit()
	
	Globals.tutorial = Globals.Tutorial.SHOOT
	Events.chest_opened.emit()
