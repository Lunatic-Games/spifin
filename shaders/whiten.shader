shader_type canvas_item;

uniform float amount: hint_range(0.0, 1.0);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 mixed = mix(color, vec4(1.0), amount);
	COLOR = vec4(mixed.rgb, color.a);
}