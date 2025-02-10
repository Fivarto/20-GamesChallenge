extends Node2D

@onready var player_current_score = $PlayerCurrentScore
@onready var player_highest_score = $PlayerHighestScore

@onready var new_wave_timer: Timer = $NewWaveTimer

@onready var player_life_displayer = $PlayerLifeDisplayer

@onready var spawner: Node2D = $SpawnPoints/Spawner

var spawning_new_wave: bool = false



func _process(delta):
	
	var inimigos = get_tree().get_nodes_in_group("inimigos")
	
	if inimigos.size() == 0:
		spawner.spawn_enemy()
	
	#SE A QUANTIDADE DE INIMIGOS EM TELA FOR 1(EQUIVALENTE A 0) 
	#PASSAR PRO PROXIMO NIVEL E SPAWNAR MAIS INIMIGOS
	
	player_current_score.text = str(Global.player_current_score)
	player_highest_score.text = str(Global.player_highest_score)
	
	if Global.player_current_score > Global.player_highest_score:
		Global.player_highest_score = Global.player_current_score
	
	#PLAYER LIFE DISPLAYER 
	
	match Global.player_life:
		3:
			player_life_displayer.frame = 0
		2:
			player_life_displayer.frame = 1
		1:
			player_life_displayer.frame = 2
		0:
			player_life_displayer.frame = 3
	
	#------------------------------------------


func _on_button_pressed():
	Global.save_high_score()
	get_tree().quit()
