extends Node

var player_current_score: int 
var player_highest_score: int

var player_life: int = 3

var enemies_on_screen: int = 1
var max_enemies_on_level: int = 18

var current_level: int

func _ready():
	load_high_score()

func save_high_score():
	var file = FileAccess.open("user://highscore.json", FileAccess.WRITE)
	file.store_var(player_highest_score)

func load_high_score():
	
	if FileAccess.file_exists("user://highscore.json"):
		var file = FileAccess.open("user://highscore.json", FileAccess.READ)
		player_highest_score = file.get_var()
	else:
		player_highest_score = 0
