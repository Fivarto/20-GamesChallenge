extends Node2D

@onready var player_current_score = $PlayerCurrentScore
@onready var player_life_displayer = $PlayerLifeDisplayer



func _process(delta):
	
	player_current_score.text = str(Global.player_current_score)
	
	#PLAYER LIFE DISPLAYER 
	if Global.player_life == 3:
		player_life_displayer.frame = 0
		
	if Global.player_life == 2:
		player_life_displayer.frame = 1
		
	if Global.player_life == 1:
		player_life_displayer.frame = 2
		
	if Global.player_life == 0:
		player_life_displayer.frame = 3
	
	#------------------------------------------
