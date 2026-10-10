extends Node2D

@export var bullet_scene : PackedScene
@export var bullet_speed = 500.0
@export var asteroid_scene : PackedScene
@export var particles : PackedScene


var player

func _ready():
	player = $Player
	
	var asteroids = get_tree().get_nodes_in_group("Asteroid")
	for a in asteroids:
		a.blow_up.connect(_on_asteroid_blow_up)
		a.player_hit.connect(_on_asteroid_player_hit)

func _process(delta):
	var asteroids = get_tree().get_nodes_in_group("Asteroid")
	if len(asteroids) == 0:
		print("zero")
	
func _on_player_shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = player.position
	bullet.velocity = Vector2.RIGHT.rotated(player.rotation) * bullet_speed
	bullet.rotate(player.rotation)
	add_child(bullet)

func create_new_asteroid(s, p, v):
	var asteroid = asteroid_scene.instantiate()
	asteroid.blow_up.connect(_on_asteroid_blow_up)
	asteroid.player_hit.connect(_on_asteroid_player_hit)
	asteroid.scale = s / 2
	asteroid.position = p
	asteroid.velocity = v
	asteroid.rotation = randf() * 2*PI
	add_child(asteroid)

func _on_asteroid_blow_up(a_scale: Vector2, a_pos: Vector2, a_vel: Vector2):
	if abs(a_scale.x) > 0.2:
		for i in range(3): create_new_asteroid(a_scale, a_pos, a_vel)
	var part = particles.instantiate()
	part.position = a_pos
	add_child(part)

func end_game():
	$GameOverContainer.show()

func _on_asteroid_player_hit(player_pos: Vector2) -> void:
	var part = particles.instantiate()
	part.position = player_pos
	add_child(part)
	end_game()
