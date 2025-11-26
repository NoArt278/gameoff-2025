extends CollisionShape2D

@onready var particles_sprite: Sprite2D = $"../ParticlesSprite"

func _ready() -> void:
	var collision_shape : RectangleShape2D = shape
	
	var gradient_texture : GradientTexture2D = particles_sprite.texture
	gradient_texture.width = ceil(collision_shape.size.x)
	gradient_texture.height = ceil(collision_shape.size.y)
	particles_sprite.position = position
