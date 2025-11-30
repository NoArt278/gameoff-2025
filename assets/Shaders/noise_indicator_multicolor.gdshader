shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform vec4 color_2 : source_color = vec4(1.0);
uniform vec4 color_3 : source_color = vec4(1.0);
uniform float move_speed = 3.0;
uniform float outer_radius = 30.0;
uniform float inner_radius = 25.0;
uniform float amplitude = 5.0;
uniform float frequency = 20.0;

varying vec2 vertex_pos;

float random(vec2 v) {
	return fract(sin(dot(v, vec2(12.9898, 78.233))) * 43758.5453);
}

void vertex() {
	vertex_pos = VERTEX;
}

void fragment() {
	float seed = random(vertex_pos);

	float t = TIME * move_speed;
	float angle = atan(vertex_pos.y, vertex_pos.x);
	float sine_value = sin(angle * round(frequency) + TIME * move_speed) * amplitude;

    // Apply sine wave to circle radius
    float wavy_outer_radius = outer_radius + sine_value;
	float wavy_inner_radius = inner_radius + sine_value;
						
	float outer_circle = pow(vertex_pos.x, 2) + pow(vertex_pos.y, 2) - pow(wavy_outer_radius,2);
	float inner_circle = pow(vertex_pos.x, 2) + pow(vertex_pos.y, 2) - pow(wavy_inner_radius,2);
	
	float degree_angle = degrees(angle) + 180.0;
	if (outer_circle <= outer_radius && inner_circle >= inner_radius &&
	 random(vec2(vertex_pos.x + TIME, vertex_pos.y + TIME)) < 0.2) {
		if (degree_angle > 330.0 || (degree_angle >= 0.0 && degree_angle < 90.0)) {
			COLOR = color;
		} else if (degree_angle > 90.0 && degree_angle < 210.0) {
			COLOR = color_2;
		} else {
			COLOR = color_3;
		}
	} else {
		COLOR = vec4(0.0);
	}
}
