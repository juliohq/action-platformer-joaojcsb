extends Node2D


@export var animator: AnimationPlayer
@export var player_detector: Area2D
@export var audio: AudioStreamPlayer


func _ready() -> void:
	if Globals.tutorial < Globals.Tutorial.SHOOT:
		player_detector.body_entered.connect(_player_entered, CONNECT_ONE_SHOT)


func _player_entered(_body: Node2D) -> void:
	animator.play("OPEN")
	audio.play()
	await animator.animation_finished
	
	# Update orbs
	Globals.red_orbs = 1
	Globals.blue_orbs = 1
	Events.orb_added.emit()
	
	Globals.tutorial = Globals.Tutorial.SHOOT
	Events.chest_opened.emit()
