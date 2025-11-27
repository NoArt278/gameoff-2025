extends Control

@onready var grid_container: GridContainer = $GridContainer

func _ready() -> void:
	for i : int in range(grid_container.get_child_count()) :
		var current_btn : Button = grid_container.get_child(i)
		current_btn.pressed.connect(func() : load_level(i+1))

func load_level(level : int) -> void:
	Globals.current_level = level
	get_tree().change_scene_to_file("res://scenes/main_world.tscn")
