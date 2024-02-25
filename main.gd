extends Node2D

@export var bullet_scene : PackedScene
@export var bullet_speed = 500.0


var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_shoot():
	print("shoot")
	var bullet = bullet_scene.instantiate()
	bullet.position = player.position
	#bullet.velocity = player.velocity
	bullet.velocity = Vector2.RIGHT.rotated(player.rotation) * bullet_speed
	bullet.rotate(player.rotation)
	add_child(bullet)
