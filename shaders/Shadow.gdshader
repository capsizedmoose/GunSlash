shader_type canvas_item;

uniform vec4 shadow_color : source_color;
uniform vec2 offset_in_pixels;

void fragment() {
	vec4 current_color = texture(TEXTURE, UV);
	vec2 offset = vec2(offset_in_pixels.x * TEXTURE_PIXEL_SIZE.x,offset_in_pixels.y * TEXTURE_PIXEL_SIZE.y);
	vec4 offset_shadow = texture(TEXTURE, UV - offset);
	offset_shadow.a = max(0,offset_shadow.a - current_color.a);
	if (current_color.a < 0.01 && offset_shadow.a < 0.01) {
		discard;
	}
	
	COLOR = mix(shadow_color,current_color,current_color.a);
}