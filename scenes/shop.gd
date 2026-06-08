extends Node2D


@export var action: Area2D


func _ready() -> void:
	action.used.connect(_used)


func _used() -> void:
	Events.shop_entered.emit()
