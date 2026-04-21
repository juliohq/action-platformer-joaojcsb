extends Area2D


## Emitted when picked up.
signal picked_up()


func _ready() -> void:
	await get_tree().physics_frame
	body_entered.connect(_collected)


func _collected(_body: Node2D) -> void:
	picked_up.emit()
