extends StaticBody2D

@onready var sprite_paddle = $SpritePaddle

var paddle_speed: float = 350.0

var paddle_witdh: float

func _ready():
	
	paddle_witdh = sprite_paddle.get_rect().size.x
	
	pass

func _process(delta):
	
	if Input.is_action_pressed("Move_Left"):
		position.x -= paddle_speed * delta
	
	if Input.is_action_pressed("Move_Right"):
		position.x += paddle_speed * delta
	
	position.x = clamp(position.x, 0 + (paddle_witdh / 2) , get_viewport().size.x - (paddle_witdh / 2))
