extends Control

@export var prev_screen : Control
@onready var controls_keyboard: Label = $ControlsKeyboard
@onready var controls_mobile: Label = $ControlsMobile

func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios") :
		controls_keyboard.visible = false
		controls_mobile.visible = true

func close_tutorial() -> void:
	visible = false
	if prev_screen :
		prev_screen.visible = true
