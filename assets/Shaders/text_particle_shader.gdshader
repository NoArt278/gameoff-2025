shader_type canvas_item;
render_mode world_vertex_coords;

uniform int pixel_interval = 1;
uniform float move_speed = 1.0;
uniform float radius = 0.5;
uniform float amplitude = 0.2;

varying vec2 vertex_pos;

float random(vec2 v) {
	return fract(sin(dot(v, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	vertex_pos = VERTEX;
}

void fragment() {
	vec4 text_color = texture(TEXTURE, UV);
	if (text_color.a > 0.0) {
		vec2 screen_size = vec2(1.0 / SCREEN_PIXEL_SIZE.x, 1.0 / SCREEN_PIXEL_SIZE.y);
		int dot_pixel_interval = 8;
		if (pixel_interval > 0) {
			dot_pixel_interval = pixel_interval;
		}
		vec2 grid_pos = floor(vertex_pos / float(dot_pixel_interval));

		float seed = random(grid_pos);

		float t = TIME * move_speed;
		float offset_x = sin(t + seed * 10.0) * amplitude;
		float offset_y = cos(t + seed * 10.0) * amplitude;

		vec2 dot_pos = (grid_pos * float(dot_pixel_interval)) + vec2(offset_x, offset_y);
		float dist = distance(vertex_pos, dot_pos);
		if (dist > radius) { // dot radius
			COLOR = vec4(0.0);
		}
	}
}
