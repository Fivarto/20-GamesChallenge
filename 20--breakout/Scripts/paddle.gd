extends StaticBody2D

var paddle_speed: float = 350.0



func _process(delta):
	
	if Input.is_action_pressed("Move_Left"):
		position.x -= paddle_speed * delta
	
	if Input.is_action_pressed("Move_Right"):
		position.x += paddle_speed * delta
