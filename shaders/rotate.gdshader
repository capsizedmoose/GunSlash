shader_type canvas_item;

uniform sampler2D tex;
uniform float speed;

vec2 rotate(vec2 uv, vec2 pivot, float angle)
{
	mat2 rotation = mat2(vec2(sin(angle), -cos(angle)),
						vec2(cos(angle), sin(angle)));
	
	uv -= pivot;
	uv = uv * rotation;
	uv += pivot;
	return uv;
}


void fragment() {
	vec4 col = COLOR;
    COLOR = texture(tex, rotate(UV,vec2(.5,.5),TIME*speed)) * col;
}