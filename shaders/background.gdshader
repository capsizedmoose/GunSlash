shader_type canvas_item;

uniform vec2 scroll_speed;
uniform float scale = 1;
uniform vec4 color: source_color = vec4(1,1,1,1);

void fragment()
{
    vec2 uv = UV;
    COLOR = texture(TEXTURE, uv*scale + (scroll_speed * TIME)) * color;
}