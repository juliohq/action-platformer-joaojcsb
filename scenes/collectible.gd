extends Area2D


## Emitted when picked up.
signal picked_up()


func _ready() -> void:
	body_entered.connect(_collected)


func _collected(_body: Node2D) -> void:
	picked_up.emit()
