extends CharacterBody2D

var ball_speed: float = 150.0
var ball_direction: Vector2

func _ready():
	ball_direction = Vector2(0, 1)

func _physics_process(delta):
	
	var collision = move_and_collide(ball_direction * ball_speed * delta)
	var collider
	
	if collision:
		
		collider = collision.get_collider()
		
		ball_direction = ball_direction.bounce(collision.get_normal())
	
