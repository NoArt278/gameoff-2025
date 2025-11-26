@abstract extends StaticBody2D

class_name AudioAffectedObject

enum AudioRange { LOW, MEDIUM, HIGH }

@export var frequency_effect_range : AudioRange
@onready var particle_sprite: Sprite2D = $ParticlesSprite
var noise_shader_material: ShaderMaterial
var current_color: Color = Color.WHITE

func _ready() -> void:
	noise_shader_material = particle_sprite.material

@abstract func audio_effect(delta : float = 1) -> void

func recolor_particles() -> void:
	var shader_material : ShaderMaterial = particle_sprite.material
	current_color = Globals.wave_manager.block_color_gradient.get_color(frequency_effect_range)
	shader_material.set_shader_parameter("color", current_color)
