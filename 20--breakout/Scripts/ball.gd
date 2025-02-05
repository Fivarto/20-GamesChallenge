extends CharacterBody2D

var ball_speed: float = 150.0
var ball_direction: Vector2

var ball_rotation_speed: float = 0.05

var paddle_width: float = 64.0

const MAX_X_VECTOR : float = 0.6

const BALL_ACCELERATION: float = 5

func _ready():
	ball_direction = Vector2(0, 1)

func _physics_process(delta):
	
	var collision = move_and_collide(ball_direction * ball_speed * delta)
	var collider
	
	rotation += ball_rotation_speed
	
	if collision:
		
		ball_rotation_speed = ball_rotation_speed * -1
		
		collider = collision.get_collider()
		
		if collider.name == "Player":
			ball_speed += BALL_ACCELERATION
			ball_direction = balls_new_direction(collider)
		
		if collider.is_in_group("Blocks"):
			collider.get_damaged()
		
		ball_direction = ball_direction.bounce(collision.get_normal())
	


func balls_new_direction(collider):
	
	var ball_x_position = position.x
	var paddle_x = collider.position.x
	var new_direction_distance = ball_x_position - paddle_x
	var new_direction := Vector2()
	
	if ball_direction.y > 0:
		new_direction.y = 1
		
	else:
		new_direction.y = -1
	
	new_direction.x = (new_direction_distance / (64 / 2)) * MAX_X_VECTOR
	return new_direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	position = get_viewport().size / 2
