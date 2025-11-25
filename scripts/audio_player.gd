extends AudioStreamPlayer2D

var playback : AudioStreamPlayback
@onready var sample_hz : float = stream.mix_rate
var phase : float = 0.0

func _ready() -> void:
	play()
	playback = get_stream_playback()

func fill_buffer(frequency_range : float) -> void:
	var global_freq_range = Globals.get_max_frequency() - Globals.get_min_frequency()
	var frequency : float = Globals.get_min_frequency() + global_freq_range * frequency_range
	var increment = frequency / sample_hz
	var frames_available = playback.get_frames_available()
	
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(phase * TAU))
		phase = fmod(phase + increment, 1.0)

func _process(_delta: float) -> void:
	# Divide frequency range into 10
	var curr_audio_range : float = 0
	var active_key_press_count : int = 0
	
	for i : int in range(10):
		if Input.is_key_pressed(KEY_0 + i):
			if i == 0 :
				curr_audio_range += 10
			else :
				curr_audio_range += i
			active_key_press_count += 1
	if active_key_press_count > 0 :
		curr_audio_range /= active_key_press_count
		fill_buffer(curr_audio_range / 10)
	else :
		phase = 0.0
