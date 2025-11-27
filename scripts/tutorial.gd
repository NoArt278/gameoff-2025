extends Control

@export var prev_screen : Control

func close_tutorial() -> void:
	visible = false
	if prev_screen :
		prev_screen.visible = true
