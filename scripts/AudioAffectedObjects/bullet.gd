extends AudioDestructibleObject

class_name Bullet

var velocity : Vector2

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_destroyed :
		return
	
	if body is Player :
		body.die()
	if body != self :
		destroy()

func _physics_process(delta: float) -> void:
	if not(is_destroyed) and is_currently_visible :
		audio_effect(delta)
		position += velocity * delta
