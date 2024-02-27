extends Node2D

@export var bullet_scene : PackedScene
@export var bullet_speed = 500.0
@export var asteroid_scene : PackedScene


var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player
	
	var asteroids = get_tree().get_nodes_in_group("Asteroid")
	for a in asteroids:
		a.blow_up.connect(_on_asteroid_blow_up)

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

func create_new_asteroid(s, p, v):
	var asteroid = asteroid_scene.instantiate()
	asteroid.blow_up.connect(_on_asteroid_blow_up)
	asteroid.scale = s / 2
	asteroid.position = p
	asteroid.velocity = v
	asteroid.rotation = randf() * 2*PI
	add_child(asteroid)

func _on_asteroid_blow_up(a_scale: Vector2, a_pos: Vector2, a_vel: Vector2):
	print(a_scale)
	if abs(a_scale.x) > 0.2:
		for i in range(3): create_new_asteroid(a_scale, a_pos, a_vel)
	
