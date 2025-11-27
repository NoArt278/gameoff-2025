shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform int pixel_interval = 0;
uniform float move_speed = 3.0;
uniform float radius = 0.3;
uniform float amplitude = 5.0;

varying vec2 vertex_pos;

float random(vec2 v) {
	return fract(sin(dot(v, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	vertex_pos = VERTEX;
}

void fragment() {
	vec2 screen_size = vec2(1.0 / SCREEN_PIXEL_SIZE.x, 1.0 / SCREEN_PIXEL_SIZE.y);
	int dot_pixel_interval = 8;
	if (pixel_interval > 0) {
		dot_pixel_interval = pixel_interval;
	}
	vec2 grid_pos = floor(vertex_pos / float(dot_pixel_interval));

	vec2 all_grid_pos[9] = vec2[9] (grid_pos, grid_pos + vec2(1.0,0.0), grid_pos + vec2(-1.0,0.0),
		grid_pos + vec2(0.0, 1.0), grid_pos + vec2(0.0, -1.0), grid_pos + vec2(1.0,1.0),
		grid_pos + vec2(1.0, -1.0), grid_pos + vec2(-1.0, 1.0), grid_pos + vec2(-1.0, -1.0));

	for(int i=0; i<all_grid_pos.length(); i++) {
		float seed = random(all_grid_pos[i]);

		float t = TIME * move_speed;
		float offset_x = sin(t + seed * 10.0) * amplitude;
		float offset_y = cos(t + seed * 10.0) * amplitude;

		vec2 dot_pos = (all_grid_pos[i] * float(dot_pixel_interval)) + vec2(offset_x, offset_y);
		float dist = distance(vertex_pos, dot_pos);
		if (dist < radius) {
			COLOR = color;
		}
	}
}
