shader_type canvas_item;

uniform vec4 glow_color : source_color = vec4(0.0, 1.0, 1.0, 1.0);
uniform float speed = 3.0;

void fragment()
{
    vec4 tex = texture(TEXTURE, UV);

    float pulse = sin(TIME * speed) * 0.5 + 0.5;

    tex.rgb += glow_color.rgb * pulse;

    COLOR = tex;
}