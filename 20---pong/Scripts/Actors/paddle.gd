extends StaticBody2D

@export var player_name: String = ""
@onready var sprt_paddle = $sprt_paddle

var paddle_speed: float = 250

var ball_position: Vector2
var ball_distance: int

var move_paddle_by: int

func _ready():
	
	if player_name == "Player1":
		self.modulate = Global.player_1_color
	
	if player_name == "Player2":
		self.modulate = Global.player_2_color


func _process(delta):
	
	if player_name == "Player1":
		
		if Input.is_action_pressed("P1_MOVE_UP"):
			position.y -= paddle_speed * delta
			
		if Input.is_action_pressed("P1_MOVE_DOWN"):
			position.y += paddle_speed * delta
			
		if Input.is_action_pressed("P1_MOVE_LEFT"):
			position.x -= paddle_speed * delta
			
		if Input.is_action_pressed("P1_MOVE_RIGHT"):
			position.x += paddle_speed * delta
		
	#SE O GAMEMODE FOR PVP O PLAYER 2 TEM OS CONTROLES
	elif player_name == "Player2" and Global.gamemodePVP == true:
		
		
		if Input.is_action_pressed("P2_MOVE_UP"):
			position.y -= paddle_speed * delta
			
		if Input.is_action_pressed("P2_MOVE_DOWN"):
			position.y += paddle_speed * delta
			
		if Input.is_action_pressed("P2_MOVE_LEFT"):
			position.x -= paddle_speed * delta
			
		if Input.is_action_pressed("P2_MOVE_RIGHT"):
			position.x += paddle_speed * delta
	
	#SE O GAME MODE FOR PVE ENTÃO O CPU TEM OS CONTROLES
	elif player_name == "Player2" and Global.gamemodePVE == true:
		
		ball_position = get_parent().get_node("Ball").position
		ball_distance = position.y - ball_position.y
		
		if abs(ball_distance) > paddle_speed * delta:
			move_paddle_by = paddle_speed * delta * (ball_distance / abs(ball_distance))
		else:
			move_paddle_by = ball_distance
			
		position.y -= move_paddle_by
	
	#CLAMPING POSITIONS
	if player_name == "Player1":
		position.y = clamp(position.y, 48, get_viewport().size.y - 48)
		position.x = clamp(position.x, 8 , (get_viewport().size.x / 2) - 128)
	
	if player_name == "Player2":
		position.y = clamp(position.y, 48, get_viewport().size.y - 48)
		position.x = clamp(position.x, (get_viewport().size.x / 2) + 128 , (get_viewport().size.x) - 8)
