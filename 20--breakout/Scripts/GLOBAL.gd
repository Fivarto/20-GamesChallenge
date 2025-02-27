extends Node

var player_current_score: int 
var player_highest_score: int

var player_life: int = 3

var enemies_on_screen: int 
var max_enemies_on_level: int

var current_level: int


func _ready():
	#CARREGA A PONTUAÇÃO DA ULTIMA SESSÃO
	load_high_score()

#FUNÇÃO PARA SALVAR A PONTUAÇÃO
func save_high_score():
	
	var file = FileAccess.open("user://highscore.json", FileAccess.WRITE)
	file.store_var(player_highest_score)


#FUNÇÃO PARA CARREGAR A PONTUAÇÃO
func load_high_score():
	
	if FileAccess.file_exists("user://highscore.json"):
		var file = FileAccess.open("user://highscore.json", FileAccess.READ)
		player_highest_score = file.get_var()
	else:
		player_highest_score = 0
