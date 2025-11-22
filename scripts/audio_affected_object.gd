@abstract extends Node2D

class_name AudioAffectedObject

enum AudioRange { LOW, MEDIUM, HIGH }

@abstract func audio_effect(delta : float = 1) -> void
