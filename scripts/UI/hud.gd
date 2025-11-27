extends Control

@onready var settings: Setting = $Settings

func _on_settings_button_pressed() -> void:
	settings.open_settings(null)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if settings.visible :
			settings.close_settings()
		else :
			settings.open_settings(null)
