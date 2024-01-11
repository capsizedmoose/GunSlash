shader_type canvas_item;

uniform vec4 line_color : source_color;
uniform float line_thickness : hint_range(0, 10) = 1;

const vec2 OFFSETS_8[8] = {
    vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
    vec2(1, -1), vec2(1, 0), vec2(1, 1)
};


const vec2 OFFSETS_16[16] = {
    vec2(-1, -1),vec2(-1, -.5),vec2(-1, 0),vec2(-1, .5),vec2(-1, 1), 
	vec2(-.5,-1),vec2(-.5,1),
	vec2(0, -1),vec2(0, 1), 
	vec2(.5,-1),vec2(.5,1),
    vec2(1, -1),vec2(1, -.5),vec2(1, 0),vec2(1, .5),vec2(1, 1)
};

void fragment() {
// Get the size of the pixels on screen, and create a variable for out outline
vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;

float outline;
for (int i = 0; i < OFFSETS_8.length(); i++) {
        outline += texture(TEXTURE, UV + size * OFFSETS_8[i]).a;
}
outline = min(outline, 1.0);

// Get the texture from the screen
vec4 tex = texture(TEXTURE,UV);
vec4 modulate = line_color;
modulate.a = COLOR.a;
tex = mix(tex, line_color, outline - tex.a);

COLOR = tex;
}