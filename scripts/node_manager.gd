class_name NodeManager


## Calls [code]free[/code] on all children of [code]parent[/code].
static func children_free(parent: Node) -> void:
	for child: Node in parent.get_children():
		child.free()


## Calls [code]queue_free[/code] on all children of [code]parent[/code].
static func children_queue_free(parent: Node) -> void:
	for child: Node in parent.get_children():
		child.queue_free()


## Returns the count of direct and indirect nodes of [code]parent[/code].
static func descendant_count(parent: Node) -> int:
	return parent.find_children("*", "", true, false).size()
