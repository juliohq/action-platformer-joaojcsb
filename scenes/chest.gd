extends Node2D


@export var animator: AnimationPlayer
@export var player_detector: Area2D


func _ready() -> void:
	if Globals.tutorial < Globals.Tutorial.SHOOT:
		player_detector.body_entered.connect(_player_entered, CONNECT_ONE_SHOT)


func _player_entered(_body: Node2D) -> void:
	animator.play("OPEN")
	await animator.animation_finished
	
	# Update orbs
	Globals.red_orbs = 1
	Events.orb_changed.emit()
	
	Globals.tutorial = Globals.Tutorial.SHOOT
	Events.chest_opened.emit()
