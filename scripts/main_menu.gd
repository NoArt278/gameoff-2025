extends Control

@onready var settings: Setting = $UnaffectedByVisibility/Settings

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func _on_settings_button_pressed() -> void:
	settings.open_settings(self)
	visible = false
