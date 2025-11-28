extends Control

@onready var grid_container: GridContainer = $GridContainer
@onready var settings: Setting = $UnaffectedByVisibility/Settings
@onready var bgm_mirror: BgmMirror = $UnaffectedByVisibility/BGMMirror

func _ready() -> void:
	for i : int in range(grid_container.get_child_count()) :
		var current_btn : Button = grid_container.get_child(i)
		current_btn.pressed.connect(func() : load_level(i+1))

func load_level(level : int) -> void:
	Globals.current_level = level
	get_tree().change_scene_to_file("res://scenes/main_world.tscn")

func _on_settings_button_pressed() -> void:
	settings.open_settings(self)
	visible = false


func _on_visibility_changed() -> void:
	if bgm_mirror and not(visible) :
		bgm_mirror.stop_manually()
	elif bgm_mirror :
		bgm_mirror.reset_play()
