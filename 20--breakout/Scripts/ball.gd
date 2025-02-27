extends CharacterBody2D

var ball_speed: float = 275.0
var ball_direction: Vector2

var ball_rotation_speed: float = 0.05

var paddle_width: float = 64.0

const MAX_X_VECTOR : float = 0.6

const BALL_ACCELERATION: float = 50

@onready var new_wave_timer = $"../NewWaveTimer"

signal can_spawn_new_wave

func _ready():
	#ball_direction = Vector2(0, 1)
	pass

func _input(event):
	
	#START BALL MOVEMENT
	if Input.is_key_pressed(KEY_SPACE) and Global.player_life > 0:
		start_ball_movement()

func start_ball_movement():
	ball_direction = Vector2(randf_range(-1 , 1), 1)

func _physics_process(delta):
	
	var collision = move_and_collide(ball_direction * ball_speed * delta)
	var collider
	var inimigos = get_tree().get_nodes_in_group("inimigos")
	rotation += ball_rotation_speed
	
	if collision:
		
		ball_rotation_speed = ball_rotation_speed * -1
		
		collider = collision.get_collider()
		
		if collider.name == "Player":
			
			if inimigos.size() == 0:
				can_spawn_new_wave.emit()
			
			#ball_speed += BALL_ACCELERATION
			ball_direction = balls_new_direction(collider)
		
		if collider.is_in_group("Blocks"):
			collider.get_damaged()
		
		ball_direction = ball_direction.bounce(collision.get_normal())
	


func balls_new_direction(collider):
	
	var ball_x_position = position.x
	var paddle_x = collider.position.x
	var new_direction_distance = ball_x_position - paddle_x
	var new_direction := Vector2()
	
	
	if new_direction_distance > 0:
		collider.play_bottom_bump()
	if new_direction_distance < 0:
		collider.play_top_bump()
	
	if ball_direction.y > 0:
		new_direction.y = 1
		
	else:
		new_direction.y = -1
	
	new_direction.x = (new_direction_distance / (64 / 2)) * MAX_X_VECTOR
	return new_direction



func _on_visible_on_screen_notifier_2d_screen_exited():
	
	position = get_viewport().size / 2
	ball_direction = Vector2(0, 0)
	
	Global.player_life -= 1
