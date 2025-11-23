extends CollisionShape2D

@onready var particles: CPUParticles2D = $"../Particles"


func _ready() -> void:
	var collision_shape : RectangleShape2D = shape
	particles.emission_rect_extents = Vector2(collision_shape.size.x / 2, collision_shape.size.y / 2)
