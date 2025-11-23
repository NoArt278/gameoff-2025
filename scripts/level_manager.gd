extends Node

@export var all_levels : Array[Resource]
var current_level_number : int
var current_level_scene : Node2D
var current_goal : Goal

func _ready() -> void:
	load_level(Globals.last_finished_level)

func load_level(level : int) -> void :
	if current_level_scene :
		current_goal.level_cleared.disconnect(advance_level)
		current_level_scene.queue_free()
	
	if level <= all_levels.size() :
		current_level_number = level
		current_level_scene = all_levels[level-1].instantiate()
		add_child(current_level_scene)
		current_goal = current_level_scene.find_child("Goal")
		current_goal.level_cleared.connect(advance_level)
		
		if level > Globals.last_finished_level :
			Globals.last_finished_level = level

func advance_level() -> void :
	load_level(current_level_number + 1)
