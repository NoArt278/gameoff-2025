extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var destroy_particles: CPUParticles2D = $DestroyParticles
@onready var particles_sprite: Sprite2D = $ParticlesSprite
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var die_sound: AudioStreamPlayer2D = $DieSound
var can_move: bool = true

signal died

func _physics_process(delta: float) -> void:
	if not(can_move) :
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die() -> void:
	die_sound.play()
	can_move = false
	collision_shape_2d.disabled = true
	collision_layer = 2
	particles_sprite.visible = false
	destroy_particles.restart()
	await destroy_particles.finished
	died.emit()
