extends Node2D

@onready var player_current_score = $PlayerCurrentScore
@onready var player_highest_score = $PlayerHighestScore

@onready var new_wave_timer: Timer = $NewWaveTimer

@onready var player_life_displayer = $PlayerLifeDisplayer

@onready var spawner: Node2D = $SpawnPoints/Spawner

@onready var ball = $Ball


@onready var end_game_screen = $EndGameScreen


func _process(delta):
	
	var inimigos = get_tree().get_nodes_in_group("inimigos")
	
	if inimigos.size() == 0 and new_wave_timer.is_stopped():
		
		Global.current_level += 1
		
		new_wave_timer.start()
		#spawner.spawn_enemy()
	
	#SE A QUANTIDADE DE INIMIGOS EM TELA FOR 1(EQUIVALENTE A 0) 
	#PASSAR PRO PROXIMO NIVEL E SPAWNAR MAIS INIMIGOS
	
	match Global.current_level:
		1:
			Global.max_enemies_on_level = 6
		2:
			Global.max_enemies_on_level = 12
		3:
			Global.max_enemies_on_level = 18
		_:
			Global.max_enemies_on_level = 18
	
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
			end_game_screen.visible = true
	
	#------------------------------------------


func _on_button_pressed():
	Global.save_high_score()
	get_tree().quit()


func _on_new_wave_timer_timeout():
	print("New Wave Coming")
	spawner.spawn_enemy()


#RESTART GAME BUTTON
func _on_bt_restart_level_pressed():
	
	
	Global.current_level = 1
	Global.player_life = 3
	
	Global.player_current_score = 0
	
	ball.position = get_viewport().size / 2
	
	end_game_screen.visible = false
	

# BACK TO MAIN MENU BUTTON
func _on_bt_back_to_menu_pressed():
	Global.save_high_score()
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")


#EXIT TO DESKTOP BUTTON
func _on_bt_exit_game_pressed():
	Global.save_high_score()
	get_tree().quit()
