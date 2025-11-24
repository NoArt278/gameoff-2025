extends AudioAffectedObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	particles.color = Globals.wave_manager.block_color_gradient.get_color(frequency_effect_range)


func audio_effect(delta : float = 1) -> void:
	var global_freq_range : float = (Globals.get_max_frequency() - Globals.get_min_frequency())
	var min_freq : float = Globals.get_min_frequency() + (global_freq_range * frequency_effect_range/ AudioRange.size())
	var max_freq : float = Globals.get_min_frequency() + (global_freq_range * (frequency_effect_range + 1) / AudioRange.size())
	var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
	
	if curr_energy > 0 :
		pass
