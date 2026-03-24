shader_type spatial;
render_mode cull_disabled, blend_add, depth_prepass_alpha;

uniform vec3 color : source_color;

float fresnel(float amount, vec3 normal, vec3 view) {
	return pow(1.0 - (clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void fragment() {
	float f = fresnel(3.0, NORMAL, VIEW);
	ALBEDO = color + f;
	ALPHA = f;
}
