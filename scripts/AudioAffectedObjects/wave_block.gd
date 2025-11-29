extends AudioAffectedObject

class_name WaveBlock

@export var target_position : Vector2
var spawn_position : Vector2
var base_amplitude : float = 5.0
var base_move_speed : float = 3.0
var base_pixel_interval : int = 5
var base_radius : float = 0.4

func _ready() -> void:
	super()
	spawn_position = position
	noise_shader_material.set_shader_parameter("amplitude", base_amplitude)
	noise_shader_material.set_shader_parameter("move_speed", base_move_speed)
	noise_shader_material.set_shader_parameter("pixel_interval", base_pixel_interval)
	noise_shader_material.set_shader_parameter("radius", base_radius)
	recolor_particles()

func audio_effect(delta : float = 1) -> void:
	var global_freq_range : float = (Globals.get_max_frequency() - Globals.get_min_frequency())
	var min_freq : float = Globals.get_min_frequency() + (global_freq_range * frequency_effect_range/ AudioRange.size())
	var max_freq : float = Globals.get_min_frequency() + (global_freq_range * (frequency_effect_range + 1) / AudioRange.size())
	var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
	
	noise_shader_material.set_shader_parameter("move_speed", max(base_move_speed * curr_energy, base_move_speed))
	#noise_shader_material.set_shader_parameter("radius", max(base_radius * curr_energy / 3, base_radius))
	if curr_energy > 0 :
		position = position.lerp(target_position, delta * curr_energy)
	else :
		position = position.lerp(spawn_position, delta * 0.4)
		#noise_shader_material.set_shader_parameter("move_speed", base_move_speed)
		#noise_shader_material.set_shader_parameter("pixel_interval", base_pixel_interval)

func _physics_process(delta: float) -> void:
	audio_effect(delta)
