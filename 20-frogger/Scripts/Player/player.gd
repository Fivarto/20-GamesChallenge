extends Node2D





func _input(event):
	
	#MOVE UP
	if Input.is_action_just_pressed("Move_Up"):
		position.y -= 32
	
	#MOVE_DOWN
	if Input.is_action_just_pressed("Move_Down"):
		position.y += 32
	
	#MOVE_LEFT
	if Input.is_action_just_pressed("Move_Left"):
		position.x -= 32
	
	#MOVE_RIGHT
	if Input.is_action_just_pressed("Move_Right"):
		position.x += 32
