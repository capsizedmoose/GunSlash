shader_type canvas_item;

uniform bool flash = true;
uniform vec4 color: source_color = vec4(1);

void fragment() {
	if(flash){
		vec4 col = color;
		float max_col = max(max(COLOR.r,COLOR.g),COLOR.b);
		if(max_col > .3){
			col.a = COLOR.a;
			COLOR = (max_col > .1 )?col:COLOR;
		}
	}
}
