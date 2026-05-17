extends Area2D


@export var parent: Node


func _ready() -> void:
	body_entered.connect(_body_entered)


func _body_entered(_body: Node2D) -> void:
	parent.queue_free()
