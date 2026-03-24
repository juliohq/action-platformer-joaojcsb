extends Control


@export var sequence: PackedStringArray

var current := -1


func _ready() -> void:
	assert(sequence, "sequence is empty")
	next()


func update() -> void:
	%Text.text = sequence[current]
	%Previous.disabled = current == 0
	%Next.disabled = current == sequence.size() - 1


func previous() -> void:
	current = clampi(current - 1, 0, sequence.size())
	update()


## Handles the logic when the back button is pressed. Override to provide custom behavior.
func _back() -> void:
	queue_free()


func next() -> void:
	current = clampi(current + 1, 0, sequence.size())
	update()
