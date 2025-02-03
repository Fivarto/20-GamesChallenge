extends CharacterBody2D

var ball_speed: float = 150
var ball_direction: Vector2

const BALL_ACCELERATION: int = 20
const MAX_Y_VECTOR: float = 0.6

@onready var ball_bump_sfx: AudioStreamPlayer2D = $paddle_bump_sfx
@onready var score_sfx: AudioStreamPlayer2D = $score_sfx


func _ready():
	
	pass

func ball_respawn():
	position.x = get_viewport().size.x / 2
	position.y = randi_range(240, get_viewport().size.y - 240)
	
	ball_direction = ball_random_start_direction()


func _physics_process(delta):
	
	rotation = rotation + 0.05
	
	var collision = move_and_collide(ball_direction * ball_speed * delta)
	var collider
	
	if collision:
		
		collider = collision.get_collider()
		
		if collider.name == "Player1" || collider.name == "Player2":
			
			#ACELERA A BOLA 
			ball_speed += BALL_ACCELERATION
			
			#SOM AO REBATER A BOLA
			ball_bump_sfx.pitch_scale = randf_range(0.9 , 1.2)
			ball_bump_sfx.play()
			
			#"QUICA" A BOLA PRO OUTRO LADO DO COLLIDER
			ball_direction = balls_new_direction(collider)
			
		else:
			
			ball_direction = ball_direction.bounce(collision.get_normal())
	

func ball_random_start_direction():
	var new_random_ball_direction := Vector2()
	new_random_ball_direction.x = [-1, 1].pick_random()
	new_random_ball_direction.y = randf_range(-1, 1)
	
	return new_random_ball_direction.normalized()

func balls_new_direction(collider):
	
	var ball_y = position.y
	var paddle_y = collider.position.y
	var new_direction_distance = ball_y - paddle_y
	var new_direction := Vector2()
	
	#NOVA DIREÇÃO NO EIXO X
	#REFLETINDO A BOLA NA HORIZONTAL
	if ball_direction.x > 0: #OU SEJA, A BOLA ESTÁ SE MOVENDO DA ESQUERDA PRA DIREITA
		new_direction.x = -1
		
	else: # A BOLA ESTÁ SE MOVENDO DA DIREITA PRA ESQUERDA
		new_direction.x = 1
	
	
	#NOVA DIREÇÃO NO EIXO Y
	new_direction.y = (new_direction_distance / (96 / 2)) * MAX_Y_VECTOR
	
	return new_direction

func play_score_sfx():
	score_sfx.play()
