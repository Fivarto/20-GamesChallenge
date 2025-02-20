extends CharacterBody2D

signal player_hit
signal drowning

@onready var sprite_player = $Sprite_Player

@export var respawn_location: Marker2D

var new_position: Vector2 = Vector2.ZERO

var enabled: bool = true


func _input(event):
	
	var position_candidate
	
	if !enabled:
		return
	
	#MOVE UP
	if Input.is_action_just_pressed("Move_Up"):
		sprite_player.rotation_degrees = 0
		position.y -= 32
	
	#MOVE_DOWN
	if Input.is_action_just_pressed("Move_Down"):
		sprite_player.rotation_degrees = 180
		position.y += 32
	
	#MOVE_LEFT
	if Input.is_action_just_pressed("Move_Left"):
		sprite_player.rotation_degrees = -90
		position.x -= 32
	
	#MOVE_RIGHT
	if Input.is_action_just_pressed("Move_Right"):
		sprite_player.rotation_degrees = 90
		position.x += 32


func died():
	enabled = false
	
	$Sprite_Player.visible = false
	$SparkleSplatter.emitting = true
	
	await $SparkleSplatter.finished
	
	$RespawnEffect.emitting = true
	self.position = respawn_location.position
	
	await $RespawnEffect.finished
	
	$Sprite_Player.visible = true
	
	enabled = true


func _on_player_area_damaged(area):
	
	died()
	emit_signal("player_hit")


func _on_drowning_detector_drowned():
	died()
	emit_signal("drowning")
	print("Drowning")
