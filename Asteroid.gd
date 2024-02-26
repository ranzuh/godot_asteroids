extends Node2D

func _on_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.is_in_group("Bullet"):
		queue_free()
	if area.is_in_group("Player"):
		area.kill()
