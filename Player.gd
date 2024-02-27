extends Node2D

@export var thrust = 200.0
@export var rotation_speed = 90.0
@export var speed_limit = 300.0

@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_stream_player_2 = $AudioStreamPlayer2


var velocity = Vector2(10.0, 0.0)

signal shoot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_released("ui_up"):
		if audio_stream_player_2.playing:
			audio_stream_player_2.stop()
	if Input.is_action_pressed("ui_right"):
		#print("rotate right")
		rotate(deg_to_rad(rotation_speed * delta))
	if Input.is_action_pressed("ui_left"):
		#print("rotate left")
		rotate(deg_to_rad(-rotation_speed * delta))
	if Input.is_action_pressed("ui_up"):
		#print("thrust forward")
		velocity += Vector2.RIGHT.rotated(rotation) * thrust * delta
		velocity = velocity.limit_length(speed_limit)
		if not audio_stream_player_2.playing:
			audio_stream_player_2.play()
		#print(velocity.length())
	if Input.is_action_just_pressed("ui_select"):
		shoot.emit()
		audio_stream_player.play()
	
	position += velocity * delta
	
