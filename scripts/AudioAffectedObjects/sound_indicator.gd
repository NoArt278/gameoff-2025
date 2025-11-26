extends AudioAffectedObject

var shader_material : ShaderMaterial

func _ready() -> void:
	shader_material = material

func audio_effect(_delta : float = 1) -> void:
	var detected_freq_count : int = 0
	var detected_frequency : float = 0.0
	var total_detected_index : float = 0.0
	var total_detected_energy : float = 0.0
	for i : int in range(10) :
		var global_freq_range = Globals.get_max_frequency() - Globals.get_min_frequency()
		var min_freq : float = Globals.get_min_frequency() + global_freq_range * i / 10
		var max_freq : float = Globals.get_min_frequency() + global_freq_range * (i+1) / 10
		var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
		
		if curr_energy > 0 :
			total_detected_index += i + 1
			detected_frequency += (min_freq + max_freq) / 2.0
			total_detected_energy += curr_energy
			detected_freq_count += 1
	
	visible = detected_freq_count > 0
	if visible :
		shader_material.set_shader_parameter("color", Globals.wave_manager.block_color_gradient.sample(total_detected_index / detected_freq_count / 10))
		var average_frequency = detected_frequency / detected_freq_count
		shader_material.set_shader_parameter("frequency", 50.0 * average_frequency / Globals.get_max_frequency())
		shader_material.set_shader_parameter("amplitude", total_detected_energy / detected_freq_count)

func _physics_process(delta: float) -> void:
	audio_effect(delta)
