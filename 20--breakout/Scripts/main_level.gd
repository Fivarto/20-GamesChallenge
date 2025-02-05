extends Node2D

@onready var player_current_score = $PlayerCurrentScore


func _process(delta):
	
	player_current_score.text = str(Global.player_current_score)
