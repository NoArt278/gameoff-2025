extends Node

@export var all_levels : Array[Resource]
var current_level_scene : Node2D
var current_goal : Goal
var current_player : Player

func _ready() -> void:
	load_level(Globals.current_level)

func load_level(level : int) -> void :
	if current_level_scene :
		current_goal.level_cleared.disconnect(advance_level)
		current_player.died.disconnect(retry_level)
		current_level_scene.queue_free()
	
	if level <= all_levels.size() :
		Globals.current_level = level
		current_level_scene = all_levels[level-1].instantiate()
		call_deferred("add_child", current_level_scene)
		current_goal = current_level_scene.find_child("Goal")
		if current_goal :
			current_goal.level_cleared.connect(advance_level)
		current_player = current_level_scene.find_child("Player")
		if current_player :
			current_player.died.connect(retry_level)
		
		if level > Globals.last_finished_level :
			Globals.last_finished_level = level

func advance_level() -> void :
	load_level(Globals.current_level + 1)

func retry_level() -> void:
	load_level(Globals.current_level)
