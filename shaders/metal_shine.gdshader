shader_type canvas_item;

uniform sampler2D shine_gradient : repeat_enable;
uniform mat2 transform = mat2(vec2(-0.5, 0.5), vec2(0.5, 0.5));
uniform float speed_scale = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec2 uv = vec2(UV.x + TIME * speed_scale, UV.y);
	vec4 shine = texture(shine_gradient, transform * uv);
	COLOR = mix(shine, color, shine.a);
}
