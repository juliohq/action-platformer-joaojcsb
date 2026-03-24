shader_type spatial;

varying vec4 vertex_color;

void vertex() {
	vertex_color = COLOR;
}

void fragment() {
	ALBEDO = vec3(vertex_color.r);
}
