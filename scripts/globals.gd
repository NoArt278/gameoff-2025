extends Node

const ABSOLUTE_MAX_FREQUENCY : float = 2093.0
const ABSOLUTE_MIN_FREQUENCY : float = 65.41
const MIN_DB : float = 60.0
const WAVE_MANAGER = preload("uid://dbobdx6wwq2it")
const SAVE_PATH = "user://settings.cfg"

# Level
var last_finished_level : int = 1
var current_level : int = 1

# Settings
var volume : float = 1
var mic_sensitivity : float = 15.0
var min_frequency : float = 200.0
var max_frequency : float = ABSOLUTE_MAX_FREQUENCY
var use_microphone : bool = true

var wave_manager : WaveManager

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	wave_manager = WAVE_MANAGER.instantiate()
	add_child(wave_manager)
	load_data()

func get_max_frequency() -> float : 
	return max(min_frequency, max_frequency)

func get_min_frequency() -> float : 
	return min(min_frequency, max_frequency)

func toggle_microphone(enabled : bool) -> void:
	use_microphone = enabled
	if use_microphone :
		wave_manager.mic_input.play()
	else :
		wave_manager.mic_input.stop()

func _exit_tree() -> void:
	save_data()

func load_data() -> void:
	var conf := ConfigFile.new()

	var error := conf.load(SAVE_PATH)
	if error == OK:
		volume = conf.get_value("settings", "volume", 0.7)
		mic_sensitivity = conf.get_value("settings", "mic_sensitivity", 10)
		min_frequency = conf.get_value("settings", "min_frequency", ABSOLUTE_MIN_FREQUENCY)
		max_frequency = conf.get_value("settings", "max_frequency", ABSOLUTE_MAX_FREQUENCY)
		use_microphone = conf.get_value("settings", "use_microphone", true)
		toggle_microphone(use_microphone)
		
		last_finished_level = conf.get_value("level", "last_finished_level", 1)
	else:
		print("Couldn't load save file: ", error_string(error))
	

func save_data() -> void:
	var conf := ConfigFile.new()

	conf.set_value("settings", "volume", volume)
	conf.set_value("settings", "mic_sensitivity", mic_sensitivity)
	conf.set_value("settings", "min_frequency", min_frequency)
	conf.set_value("settings", "max_frequency", max_frequency)
	conf.set_value("settings", "use_microphone", use_microphone)
	
	conf.set_value("level", "last_finished_level", last_finished_level)
	
	var error := conf.save(SAVE_PATH)
	if error == OK:
		print("saved")
	else:
		print("Error saving tspath: ", error_string(error))
