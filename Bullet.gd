extends Node2D

var velocity = Vector2(0.0, 0.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
