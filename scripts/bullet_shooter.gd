extends StaticBody2D

const BULLET = preload("uid://cbmd7beftqnlm")

@export var shoot_direction : Vector2
@export var bullet_speed : float = 5
@export var shoot_interval : float = 3.0
@export var is_affected_by_audio : bool = true
@export var shoot_delay : float = 0

@onready var bullet_spawn_pos: Node2D = $BulletSpawnPos
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if shoot_delay > 0 :
		timer.wait_time = shoot_delay
		timer.start()
		await timer.timeout
		timer.stop()
	timer.wait_time = shoot_interval
	timer.start()

func shoot() -> void:
	var bullet : Bullet = BULLET.instantiate()
	bullet_spawn_pos.add_child(bullet)
	bullet.position = Vector2.ZERO
	bullet.velocity = shoot_direction * bullet_speed
	bullet.affected_by_audio = is_affected_by_audio
	if is_affected_by_audio :
		bullet.frequency_effect_range = randi_range(0, AudioAffectedObject.AudioRange.size() - 1) as AudioAffectedObject.AudioRange
	bullet.recolor_particles()

func _on_timer_timeout() -> void:
	shoot()
