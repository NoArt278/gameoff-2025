shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
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
	float angle = atan(vertex_pos.y, vertex_pos.x); // Angle in radians

    // Apply sine wave to circle radius
    float wavy_outer_radius = outer_radius +
                        sin(angle * frequency + TIME * move_speed) * amplitude;
	float wavy_inner_radius = inner_radius +
                        sin(angle * frequency + TIME * move_speed) * amplitude;
	float outer_circle = pow(vertex_pos.x, 2) + pow(vertex_pos.y, 2) - pow(wavy_outer_radius,2);
	float inner_circle = pow(vertex_pos.x, 2) + pow(vertex_pos.y, 2) - pow(wavy_inner_radius,2);

	if (outer_circle <= outer_radius && inner_circle >= inner_radius &&
	 random(vec2(vertex_pos.x + TIME, vertex_pos.y + TIME)) < 0.2) {
		COLOR = color;
	} else {
		COLOR = vec4(0.0);
	}
}
