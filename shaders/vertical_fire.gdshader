shader_type canvas_item;

uniform sampler2D noise : filter_nearest, repeat_enable;
uniform float clip_low = 0.0;
uniform float clip_high = 1.0;
uniform sampler2D gradient : filter_nearest;
uniform sampler2D color_gradient;

void fragment() {
	// Sample noise and move up
	vec2 uv = UV + vec2(0.0, TIME);
	vec3 value = texture(noise, uv).rgb;

	// Clip noise value
	value = min(vec3(clip_high), max(vec3(clip_low), value));

	// Blend with gradient
	float gradient_value = texture(gradient, UV).r;
	value *= gradient_value;

	// Colorize
	value += texture(color_gradient, vec2(value.r, 0.0)).rgb;

	COLOR = vec4(value, 1.0);
}
