extends AudioAffectedObject

class_name WaveBlock

@export var block_frequency_range : AudioRange
@export var target_height : float
@onready var particles: CPUParticles2D = $Particles
var spawn_height : float
var facing_downward : bool = false

func _ready() -> void:
	spawn_height = position.y
	if spawn_height < target_height : 
		facing_downward = true
	particles.color = Globals.wave_manager.block_color_gradient.get_color(block_frequency_range)

func audio_effect(delta : float = 1) -> void:
	var global_freq_range : float = (Globals.get_max_frequency() - Globals.get_min_frequency())
	var min_freq : float = Globals.get_min_frequency() + (global_freq_range * block_frequency_range/ AudioRange.size())
	var max_freq : float = Globals.get_min_frequency() + (global_freq_range * (block_frequency_range + 1) / AudioRange.size())
	var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
	var curr_height : float
	
	if facing_downward :
		curr_height = target_height - curr_energy * target_height
		if curr_height < spawn_height :
			curr_height = spawn_height
		elif curr_height > target_height :
			curr_height = target_height
	else :
		curr_height = spawn_height - curr_energy * spawn_height
		if curr_height > spawn_height :
			curr_height = spawn_height
		elif curr_height < target_height :
			curr_height = target_height
	
	position.y = lerpf(position.y, curr_height, delta * 
		smoothstep(min(curr_height, position.y), max(spawn_height, position.y), max(spawn_height, position.y)))

func _physics_process(delta: float) -> void:
	audio_effect(delta)
