extends Node2D


@export var player_detector: Area2D


func _ready() -> void:
	player_detector.body_entered.connect(_player_entered)


func _player_entered(_body: Node2D) -> void:
	Events.shop_entered.emit()
