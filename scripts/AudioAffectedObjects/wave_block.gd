extends AudioAffectedObject

class_name WaveBlock

@export var target_position : Vector2
var spawn_position : Vector2

func _ready() -> void:
	spawn_position = position
	recolor_particles()

func audio_effect(delta : float = 1) -> void:
	var global_freq_range : float = (Globals.get_max_frequency() - Globals.get_min_frequency())
	var min_freq : float = Globals.get_min_frequency() + (global_freq_range * frequency_effect_range/ AudioRange.size())
	var max_freq : float = Globals.get_min_frequency() + (global_freq_range * (frequency_effect_range + 1) / AudioRange.size())
	var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
	
	if curr_energy > 0 :
		position = position.lerp(target_position, delta * curr_energy)
	else :
		position = position.lerp(spawn_position, delta * 0.4)

func _physics_process(delta: float) -> void:
	audio_effect(delta)
