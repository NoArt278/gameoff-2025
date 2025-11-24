@abstract extends StaticBody2D

class_name AudioAffectedObject

enum AudioRange { LOW, MEDIUM, HIGH }

@export var frequency_effect_range : AudioRange
@onready var particles: CPUParticles2D = $Particles

@abstract func audio_effect(delta : float = 1) -> void

func recolor_particles() -> void:
	particles.color = Globals.wave_manager.block_color_gradient.get_color(frequency_effect_range)
