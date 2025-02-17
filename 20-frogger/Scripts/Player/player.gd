extends CharacterBody2D

signal player_hit


@onready var sprite_player: AnimatedSprite2D = $Sprite_Player
@onready var player_danger_zone: Area2D = $PlayerDangerZone


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


func _on_player_danger_zone_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#print("Algo bateu na area do player")
	
	emit_signal("player_hit")
