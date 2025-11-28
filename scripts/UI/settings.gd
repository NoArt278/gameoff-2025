extends Control

class_name Setting

@onready var back_button: Button = $BackButton
@onready var volume_slider: HSlider = $VolumeSlider
@onready var mic_sensitivity_slider: HSlider = $MicSensitivitySlider
@onready var min_freq_slider: HSlider = $MinFreqSlider
@onready var max_freq_slider: HSlider = $MaxFreqSlider
@onready var mic_toggle: CheckButton = $MicToggle
@onready var bgm_toggle: CheckButton = $BGMToggle
@onready var volume_number: Label = $VolumeSlider/VolumeNumber
@onready var mic_sensitivity_number: Label = $MicSensitivitySlider/MicSensitivityNumber
@onready var min_frequency_number: Label = $MinFreqSlider/MinFrequencyNumber
@onready var max_frequency_number: Label = $MaxFreqSlider/MaxFrequencyNumber

var spectrum : AudioEffectSpectrumAnalyzerInstance
var prev_screen : Control = null
var is_setting_up : bool = false

func open_settings(prev : Control) -> void:
	get_tree().paused = true
	visible = true
	prev_screen = prev
	PhysicsServer2D.set_active(true)


func close_settings() -> void:
	get_tree().paused = false
	visible = false
	if prev_screen != null :
		prev_screen.visible = true
		prev_screen = null


func _ready() -> void:
	is_setting_up = true
	volume_slider.value = Globals.volume
	mic_sensitivity_slider.value = Globals.mic_sensitivity
	min_freq_slider.value = Globals.min_frequency
	max_freq_slider.value = Globals.max_frequency
	mic_toggle.button_pressed = Globals.use_microphone
	bgm_toggle.button_pressed = Globals.play_bgm
	
	var idx = AudioServer.get_bus_index("Microphone")
	spectrum = AudioServer.get_bus_effect_instance(idx, 1)
	
	is_setting_up = false


func _on_volume_slider_value_changed(value: float) -> void:
	Globals.volume = value
	AudioServer.set_bus_volume_linear(0, value)
	volume_number.text = str(floori(value * 100))


func _on_mic_sensitivity_slider_value_changed(value: float) -> void:
	Globals.mic_sensitivity = value
	mic_sensitivity_number.text = str(value)


func _on_min_freq_slider_value_changed(value: float) -> void:
	Globals.min_frequency = value
	min_frequency_number.text = str(value) + " Hz"


func _on_max_freq_slider_value_changed(value: float) -> void:
	Globals.max_frequency = value
	max_frequency_number.text = str(value) + " Hz"


func _on_back_button_pressed() -> void:
	close_settings()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")


func _on_mic_toggle_toggled(toggled_on: bool) -> void:
	if not(is_setting_up) :
		Globals.toggle_microphone(toggled_on)


func _on_bgm_toggle_toggled(toggled_on: bool) -> void:
	if not(is_setting_up) :
		Globals.toggle_bgm(toggled_on)


func _on_min_freq_slider_drag_ended(_value_changed: bool) -> void:
	Input.action_press("low_sound")


func _on_max_freq_slider_drag_ended(_value_changed: bool) -> void:
	Input.action_press("high_sound")


func save_settings(_val : bool) -> void:
	Globals.save_data()
