extends Node2D

var velocity := Vector2(0.0, 0.0)

signal blow_up(my_scale: Vector2, my_position: Vector2, my_velocity: Vector2)

func _ready() -> void:
	velocity.x = randf_range(-50.0, 50.0)
	velocity.y = randf_range(-50.0, 50.0)

func _process(delta: float) -> void:
	position += velocity * delta

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("Bullet"):
		area.queue_free()
		blow_up.emit(scale, position, velocity)
		queue_free()
	if area.is_in_group("Player"):
		area.queue_free()
