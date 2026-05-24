@tool
extends EditorScript


const ITEMS := [
	"res://items/apple.tres",
	"res://items/banana.tres",
	"res://items/pineapple.tres",
	"res://items/avocado.tres",
]


func _run() -> void:
	for path: String in ITEMS:
		var file := Paths.to_file(path).to_snake_case()
		print("var %s := preload(\"%s\")" % [file, path])
