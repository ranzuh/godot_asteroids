extends Node2D

@export var thrust = 200.0
@export var rotation_speed = 90.0
@export var speed_limit = 300.0

var velocity = Vector2(100.0, 0.0)

signal shoot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		#print(velocity.length())
	if Input.is_action_just_pressed("ui_select"):
		shoot.emit()
		
		
	
	position += velocity * delta
	
