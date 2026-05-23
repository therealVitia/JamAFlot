shader_type canvas_item;

uniform float strength : hint_range(0.0, 1.0) = 1.0;

void fragment()
{
    vec4 tex = texture(TEXTURE, UV);

    tex.rgb = mix(tex.rgb, vec3(1.0, 1.0, 0.0), strength);

    COLOR = tex;
}