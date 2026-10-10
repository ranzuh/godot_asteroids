extends Node2D

var velocity := Vector2(0.0, 0.0)

@export var asteroid_max_speed = 75.0

signal blow_up(my_scale: Vector2, my_position: Vector2, my_velocity: Vector2)
signal player_hit(player_pos: Vector2)

@onready var screen_size = get_viewport_rect().size
@onready var cpu_particles_2d = $CPUParticles2D

func _ready() -> void:
	velocity.x = randf_range(-asteroid_max_speed, asteroid_max_speed)
	velocity.y = randf_range(-asteroid_max_speed, asteroid_max_speed)

func _process(delta: float) -> void:
	position += velocity * delta
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("Bullet"):
		area.queue_free()
		blow_up.emit(scale, position, velocity)
		queue_free()
	if area.is_in_group("Player"):
		player_hit.emit(area.position)
		area.queue_free()
