extends Control

@onready var settings: Setting = $UnaffectedByVisibility/Settings
@onready var tutorial: Control = $UnaffectedByVisibility/Tutorial

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/level_select.tscn")


func _on_settings_button_pressed() -> void:
	settings.open_settings(self)
	visible = false


func _on_howto_play_button_pressed() -> void:
	tutorial.visible = true
	visible = false


func _on_visibility_changed() -> void:
	if Globals.wave_manager :
		Globals.wave_manager.set_bgm_mirror_play(visible)
