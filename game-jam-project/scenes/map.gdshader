shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 real = vec4(0.0, 0.0, 0.0, 0.0);
    vec4 imaginary = vec4(0.2, 0.4, 1.0, 0.8);
    COLOR = mix(real, imaginary, progress);
}