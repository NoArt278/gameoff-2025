extends AudioDestructibleObject

class_name Bullet

var velocity : Vector2
var affected_by_audio : bool = true
@export var unaffected_by_audio_color : Color

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_destroyed :
		return
	
	if body is Player :
		body.die()
	if body != self :
		destroy()

func recolor_particles() -> void:
	super()
	
	if not(affected_by_audio) :
		destroy_particles.color = unaffected_by_audio_color
		var shader_material : ShaderMaterial = particle_sprite.material
		current_color = unaffected_by_audio_color
		shader_material.set_shader_parameter("color", current_color)

func _physics_process(delta: float) -> void:
	if not(is_destroyed) and is_currently_visible :
		if affected_by_audio :
			audio_effect(delta)
		position += velocity * delta
