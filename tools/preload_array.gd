@tool
extends EditorScript


const ITEMS := [
	"res://items/apple.tres",
	"res://items/banana.tres",
	"res://items/pineapple.tres",
	"res://items/avocado.tres",
]


func _run() -> void:
	# Sort array
	var items := ITEMS.duplicate()
	items.sort()
	
	# Print
	print("var foo := [")
	
	for path: String in items:
		print("\tpreload(\"%s\")," % path)
	
	print("]")
