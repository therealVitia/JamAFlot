shader_type spatial;

uniform vec4 albedo : source_color = vec4(1.0, 0.3, 0.1, 1.0);

void fragment() {
    ALBEDO = albedo.rgb;
    ROUGHNESS = 0.8;
    METALLIC = 0.0;
}