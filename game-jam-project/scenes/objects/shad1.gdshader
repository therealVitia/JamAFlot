shader_type spatial;

uniform vec4 albedo : source_color = vec4(0.2, 0.4, 0.8, 1.0);

void fragment() {
    ALBEDO = albedo.rgb;
    ROUGHNESS = 0.8;
    METALLIC = 0.0;
}