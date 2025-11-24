extends StaticBody2D

const BULLET = preload("uid://cbmd7beftqnlm")

@export var shoot_direction : Vector2
@export var bullet_speed : float = 5
@export var shoot_interval : float = 3.0

@onready var bullet_spawn_pos: Node2D = $BulletSpawnPos
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = shoot_interval
	timer.start()
	shoot()

func shoot() -> void:
	var bullet : Bullet = BULLET.instantiate()
	bullet_spawn_pos.add_child(bullet)
	bullet.position = Vector2.ZERO
	bullet.velocity = shoot_direction * bullet_speed
	bullet.frequency_effect_range = randi_range(0, AudioAffectedObject.AudioRange.size() - 1) as AudioAffectedObject.AudioRange
	bullet.recolor_particles()

func _on_timer_timeout() -> void:
	shoot()
