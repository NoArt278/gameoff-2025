extends Node

class_name WaveManager

var effect : AudioEffectRecord
var spectrum : AudioEffectSpectrumAnalyzerInstance
var current_bgm_index : int = 0
var play_bgm_mirror : bool = true
@onready var mic_input: AudioStreamPlayer2D = $MicInput
@onready var bgm: AudioStreamPlayer2D = $BGM
@onready var bgm_mirror: AudioStreamPlayer2D = $BGMMirror
#var screen_size : Vector2
#var blocks : Array[Node2D]
#var is_setup_done : bool = false
#var spawn_height : float

#@export var wave_block_count : int = 32
@export var block_color_gradient : Gradient
@export var bgm_list : Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var idx = AudioServer.get_bus_index("Microphone")
	effect = AudioServer.get_bus_effect(idx, 0)
	spectrum = AudioServer.get_bus_effect_instance(idx, 1)
	effect.set_recording_active(true)
	current_bgm_index = randi_range(0, bgm_list.size() - 1)
	bgm.stream = bgm_list[current_bgm_index]
	bgm_mirror.stream = bgm_list[current_bgm_index]
	bgm_mirror.volume_db = AudioServer.get_bus_volume_db(0)
	if Globals.play_bgm :
		bgm.play()
		bgm_mirror.play()
	#screen_size = DisplayServer.window_get_size()
	
	#setup_level()

func get_audio_energy(min_frequency : float, max_frequency : float) -> float :
	var curr_magnitude : float = spectrum.get_magnitude_for_frequency_range(min_frequency, max_frequency).length()
	return clampf((Globals.MIN_DB + linear_to_db(curr_magnitude)) / Globals.MIN_DB, 0, 1) * Globals.mic_sensitivity

func set_bgm_play(enabled : bool) :
	if enabled :
		bgm.play()
		if play_bgm_mirror :
			bgm_mirror.play()
	else :
		bgm.stop()
		bgm_mirror.stop()

func set_bgm_mirror_play(enabled : bool) :
	play_bgm_mirror = enabled
	if enabled and Globals.play_bgm :
		bgm_mirror.play()
	else :
		bgm_mirror.stop()

#func setup_level() -> void:
	#is_setup_done = false
	#for block in blocks :
		#block.queue_free()
	#blocks.clear()
	#
	#spawn_height = screen_size.y * 6/8
	#for i : int in range(wave_block_count + 1) :
		#var new_wave_point : Node2D = WAVE_BLOCK.instantiate()
		#add_child(new_wave_point)
		#new_wave_point.position = Vector2(screen_size.x * ((float(i) + 0.5)/wave_block_count), spawn_height)
		#blocks.append(new_wave_point)
		#var col_shape : CollisionShape2D = new_wave_point.get_node("CollisionShape2D")
		#var col_rect : RectangleShape2D = col_shape.shape
		#col_rect.size = Vector2(screen_size.x / wave_block_count, screen_size.y)
		#col_shape.shape = col_rect
		#col_shape.position = Vector2(0, screen_size.y/2)
		#var particle_emitter : CPUParticles2D = new_wave_point.get_node("Particles")
		#particle_emitter.emission_rect_extents = Vector2(col_rect.size.x/2, screen_size.y/2)
		#particle_emitter.color = block_color_gradient.sample(float(i) / wave_block_count)
		#particle_emitter.position = Vector2(0, screen_size.y/2)
	#
	#await get_tree().create_timer(0.1).timeout
	#is_setup_done = true

#func _physics_process(delta: float) -> void:
	#if not(is_setup_done) :
		#return
	#
	#var prev_freq
	#if (Globals.min_frequency <= Globals.max_frequency) :
		#prev_freq = Globals.min_frequency
	#else :
		#prev_freq = Globals.max_frequency
	#var freq_range = abs(Globals.max_frequency - Globals.min_frequency) / wave_block_count
	#for i : int in blocks.size() :
		#var curr_magnitude : float = spectrum.get_magnitude_for_frequency_range(prev_freq, (i+1) * freq_range).length()
		#var curr_energy : float = clampf((Globals.MIN_DB + linear_to_db(curr_magnitude)) / Globals.MIN_DB, 0, 1) * Globals.mic_sensitivity
		#var curr_height : float = screen_size.y - curr_energy * screen_size.y
		#
		#if (curr_height > spawn_height) :
			#curr_height = spawn_height
		#
		#blocks[i].position.y = lerpf(blocks[i].position.y, curr_height, delta * 
			#smoothstep(min(curr_height, blocks[i].position.y), max(spawn_height, blocks[i].position.y), max(spawn_height, blocks[i].position.y)))
		#prev_freq = (i+1) * freq_range


func _on_bgm_finished() -> void:
	var new_index = randi_range(0, bgm_list.size() - 1)
	while current_bgm_index == new_index :
		new_index = randi_range(0, bgm_list.size() - 1)
	current_bgm_index = new_index
	bgm.stream = bgm_list[current_bgm_index]
	bgm_mirror.stream = bgm_list[current_bgm_index]
	if Globals.play_bgm :
		bgm.play()
		if play_bgm_mirror :
			bgm_mirror.play()
