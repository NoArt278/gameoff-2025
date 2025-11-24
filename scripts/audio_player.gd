extends AudioStreamPlayer2D

var playback : AudioStreamPlayback
@onready var sample_hz : float = stream.mix_rate
var pulse_hz : float
var phase : float = 0.0

func _ready() -> void:
	play()
	playback = get_stream_playback()

func fill_buffer(frequency_range : float) -> void:
	var global_freq_range = Globals.get_max_frequency() - Globals.get_min_frequency()
	var frequency : float = Globals.get_min_frequency() + global_freq_range * frequency_range / AudioAffectedObject.AudioRange.size()
	var increment = frequency / sample_hz
	var frames_available = playback.get_frames_available()
	
	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(phase * TAU))
		phase = fmod(phase + increment, 1.0)

func _process(_delta: float) -> void:
	var curr_audio_range : float = -1
	var active_key_press : int = 0
	if Input.is_action_pressed("low_sound") :
		curr_audio_range = AudioAffectedObject.AudioRange.LOW
		active_key_press += 1
	if Input.is_action_pressed("medium_sound") :
		if curr_audio_range < 0 :
			curr_audio_range = AudioAffectedObject.AudioRange.MEDIUM
		else :
			curr_audio_range += AudioAffectedObject.AudioRange.MEDIUM
		active_key_press += 1
	if Input.is_action_pressed("high_sound") :
		if curr_audio_range < 0 :
			curr_audio_range = AudioAffectedObject.AudioRange.HIGH
		else :
			curr_audio_range += AudioAffectedObject.AudioRange.HIGH
		active_key_press += 1
	
	if active_key_press > 0 :
		curr_audio_range /= active_key_press
		fill_buffer(curr_audio_range)
	else :
		phase = 0.0
