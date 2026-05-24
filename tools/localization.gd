@tool
extends EditorScript


const ITEMS := [
	"apple",
	"pineapple",
	"banana",
	"grape",
	"avocado",
	"Passion Fruit",
]


func _run() -> void:
	var items := PackedStringArray()
	
	for item: String in ITEMS:
		var item_name := item.to_snake_case().to_upper()
		items.append(item_name)
	
	items.sort()
	
	for item: String in items:
		var label := "ITEM_" + item
		var item_name := item.capitalize()
		print("%s,%s" % [label, item_name])
