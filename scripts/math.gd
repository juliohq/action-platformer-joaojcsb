class_name Math


const SQUARE_POINT_COUNT := 4


static func random_direction() -> Vector2:
	return Vector2.from_angle(TAU * randf())


static func circle(radius: float, point_count: int = 16) -> PackedVector2Array:
	# Create buffer
	var points: PackedVector2Array = []
	var err := points.resize(point_count)
	assert(err == OK)
	
	# Trace circle
	var angle_size := TAU / point_count
	
	for i: int in point_count:
		var angle := i * angle_size
		points[i] = Vector2.from_angle(angle) * radius
	
	return points


static func square(size: float) -> PackedVector2Array:
	# Create buffer
	var points: PackedVector2Array = []
	var err := points.resize(SQUARE_POINT_COUNT)
	assert(err == OK)
	
	# Trace square
	var half_size := size / 2.0
	var index := 0
	
	for y in [-1, 1]:
		for x in [-1, 1]:
			points[index] = Vector2(x, y) * half_size
			index += 1
	
	return points


static func polygon_aabb(polygon: PackedVector2Array) -> Rect2:
	var rect := Rect2()
	
	for point: Vector2 in polygon:
		rect = rect.expand(point)
	
	return rect


static func find_nearest_node(nodes: Array[Node2D], point: Vector2) -> Node2D:
	var nearest_node: Node2D
	var nearest_distance := INF
	
	for node: Node2D in nodes:
		var distance := node.global_position.distance_squared_to(point)
		
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_node = node
	
	return nearest_node


static func find_farthest_node(nodes: Array[Node2D], point: Vector2) -> Node2D:
	var farthest_node: Node2D
	var farthest_distance := INF
	
	for node: Node2D in nodes:
		var distance := node.global_position.distance_squared_to(point)
		
		if distance > farthest_distance:
			farthest_distance = distance
			farthest_node = node
	
	return farthest_node
