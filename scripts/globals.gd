extends Node

const ABSOLUTE_MAX_FREQUENCY : float = 7902.13
const MIN_DB : float = 60.0
const WAVE_MANAGER = preload("uid://dbobdx6wwq2it")

var volume : float = 1
var mic_sensitivity : float = 15.0
var min_frequency : float = 0.0
var max_frequency : float = ABSOLUTE_MAX_FREQUENCY
var wave_manager : WaveManager

func _ready() -> void:
	wave_manager = WAVE_MANAGER.instantiate()
	add_child(wave_manager)

func get_max_frequency() -> float : 
	return max(min_frequency, max_frequency)

func get_min_frequency() -> float : 
	return min(min_frequency, max_frequency)
