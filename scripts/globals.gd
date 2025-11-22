extends Node

const ABSOLUTE_MAX_FREQUENCY : float = 7902.13
const MIN_DB : float = 60.0
const WAVE_MANAGER = preload("uid://dbobdx6wwq2it")
const SAVE_PATH = "user://settings.cfg"

var volume : float = 1
var mic_sensitivity : float = 15.0
var min_frequency : float = 0.0
var max_frequency : float = ABSOLUTE_MAX_FREQUENCY
var wave_manager : WaveManager

func _ready() -> void:
	load_settings()
	wave_manager = WAVE_MANAGER.instantiate()
	add_child(wave_manager)

func get_max_frequency() -> float : 
	return max(min_frequency, max_frequency)

func get_min_frequency() -> float : 
	return min(min_frequency, max_frequency)

func _exit_tree() -> void:
	save_settings()

func load_settings():
	var conf := ConfigFile.new()

	var error := conf.load(SAVE_PATH)
	if error == OK:
		volume = conf.get_value("settings", "volume")
		mic_sensitivity = conf.get_value("settings", "mic_sensitivity")
		min_frequency = conf.get_value("settings", "min_frequency")
		max_frequency = conf.get_value("settings", "max_frequency")
	else:
		print("Couldn't load save file: ", error_string(error))
	

func save_settings():
	var conf := ConfigFile.new()

	conf.set_value("settings", "volume", volume)
	conf.set_value("settings", "mic_sensitivity", mic_sensitivity)
	conf.set_value("settings", "min_frequency", min_frequency)
	conf.set_value("settings", "max_frequency", max_frequency)

	var error := conf.save(SAVE_PATH)
	if error == OK:
		print("saved")
	else:
		print("Error saving tspath: ", error_string(error))
