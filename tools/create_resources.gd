@tool
extends EditorScript


const NAMES := [
	"Skeleton Soldier",
	"Bone Archer",
	"Rot Priest",
	"Grave Warden",
	"Ghoul Pack",
]
const OUTPUT_PATH := "res://enemies"


func _run() -> void:
	for resource_name: String in NAMES:
		var snake_case := resource_name.to_snake_case()
		
		# Create resource
		var resource := Resource.new()
		resource.name = "ENEMY_" + snake_case.to_upper()
		var path := OUTPUT_PATH.path_join(snake_case + ".tres")
		
		# Save resource to disk
		Resources.save(resource, path)
