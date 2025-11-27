extends AudioStreamPlayer2D

class_name BgmMirror

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = Globals.wave_manager.bgm.stream
	volume_db = -20.0
	if Globals.wave_manager.bgm.playing :
		play()


func _on_bgm_mirror_finished() -> void:
	reset_play()

func reset_play() -> void:
	stream = Globals.wave_manager.bgm.stream
	if Globals.wave_manager.bgm.playing :
		play()
