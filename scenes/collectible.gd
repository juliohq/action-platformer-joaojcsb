extends Area2D


## Emitted when picked up.
signal picked_up()

@export var audio: AudioStream
@export_range(0.0, 2.0, 0.01, "or_greater") var audio_volume := 1.0


func _ready() -> void:
	await get_tree().physics_frame
	body_entered.connect(_collected)


func _collected(_body: Node2D) -> void:
	AudioManager.play(audio, audio_volume, "Sounds")
	picked_up.emit()
