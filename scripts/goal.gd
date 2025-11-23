extends Area2D

class_name Goal

signal level_cleared

func _on_body_entered(body: Node2D) -> void:
	if body is Player :
		level_cleared.emit()
