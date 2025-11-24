extends AudioAffectedObject

class_name AudioDestructibleObject

@onready var destroy_particles: CPUParticles2D = $DestroyParticles
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var is_currently_visible : bool = false
var is_destroyed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	recolor_particles()


func audio_effect(_delta : float = 1) -> void:
	var global_freq_range : float = (Globals.get_max_frequency() - Globals.get_min_frequency())
	var min_freq : float = Globals.get_min_frequency() + (global_freq_range * frequency_effect_range/ AudioRange.size())
	var max_freq : float = Globals.get_min_frequency() + (global_freq_range * (frequency_effect_range + 1) / AudioRange.size())
	var curr_energy : float = Globals.wave_manager.get_audio_energy(min_freq, max_freq)
	
	if curr_energy > 0 :
		destroy()

func _physics_process(delta: float) -> void:
	if not(is_destroyed) and is_currently_visible :
		audio_effect(delta)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_currently_visible = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	is_currently_visible = false

func destroy() -> void:
	is_destroyed = true
	collision_shape_2d.disabled = true
	particles.emitting = false
	destroy_particles.restart()
	await destroy_particles.finished
	queue_free()
