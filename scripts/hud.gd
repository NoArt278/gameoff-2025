extends Control

@onready var settings: Setting = $Settings

func _on_settings_button_pressed() -> void:
	settings.open_settings(null)
