extends CharacterBody2D

signal player_hit

@export var respawn_location: Marker2D

var enabled: bool = true

func _input(event):
	
	if !enabled:
		return
	
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








func _on_player_area_damaged(area):
	
	enabled = false
	
	$Sprite_Player.visible = false
	$SparkleSplatter.emitting = true
	
	await $SparkleSplatter.finished
	
	$RespawnEffect.emitting = true
	self.position = respawn_location.position
	
	await $RespawnEffect.finished
	
	$Sprite_Player.visible = true
	
	enabled = true
	
	emit_signal("player_hit")


func _on_drowning_detector_drowned():
	print("Drowning")
