extends Node2D

@onready var start_game_label = $start_game_label
@onready var player_score_label = $player_score_label #PEGANDO O LABEL DO SCORE DO PLAYER
@onready var cpu_score_label = $cpu_score_label #PEGANDO O LABEL DO SCORE DO CPU OU PLAYER 2
@onready var win_label = $win_label #LABEL PRA MOSTRAR QUEM VENCEU

@onready var start_ball_timer = $start_ball_timer #PEGANDO O TIMER PRA COMEÇAR O MOVIMENTO DA BOLA

@onready var ball = $Ball #PEGANDO A BOLA

@onready var win_menu = $win_menu

var player_score: int = 0 # SCORE INICIAL DO PLAYER
var cpu_score: int = 0 # SCORE INICIAL DA CPU OU PLAYER 2

var has_game_started = false

func _ready():
	
	#ATUALIZANDO O TEXTO DAS LABELS DOS JOGADORES PARA O SCORE INICIAL
	cpu_score_label.text = str(cpu_score)
	player_score_label.text = str(player_score)
	


func _input(event):
	
	if Input.is_key_pressed(KEY_SPACE) and has_game_started == false:
		start_ball_timer.start()
		has_game_started = true
		start_game_label.visible = false


func _process(delta):
	
	#PLAYER WIN CONDITION
	if player_score >= 3:
		win_label.text = "CONGRATS PLAYER 1 WON"
		win_label.visible = true
		win_menu.visible = true
		get_tree().paused = true
		
	#PLAYER 2 || CPU WIN CONDITION
	if cpu_score >= 3:
		win_label.text = "CONGRATS CPU WON"
		win_label.visible = true
		win_menu.visible = true
		get_tree().paused = true

#QUANDO BOLA ENTRA NA AREA DE PONTUAÇÃO DO CPU, A CPU GANHA UM PONTO
#ATUALIZA O TEXTO DO SCORE LABEL DA CPU ADICIONANDO 1 AO PONTO
func _on_ball_enter_cpu_score_area(body):
	
	#IF STATEMENT PRA GARANTIR QUE O OBJETO QUE ENTROU NA AREA TEM O NOME "BALL"
	#IMPEDINDO QUE O LABEL E SCORE SEJA ATUALIZADOS CASO QUALQUER OUTRO OBJETO PASSE PELA AREA
	if body.name == "Ball":
		
		#ADICIONA 1 AO CPU SCORE
		cpu_score += 1
		
		#ATUALIZANDO O TEXT LABEL DA CPU
		cpu_score_label.text = str(cpu_score)
		
		#TRAZENDO A BOLA PARA O MEIO DA TELA E SETTANDO A VELOCIDADE PARA 0
		ball.ball_respawn()
		ball.ball_speed = 0
		
		#TORNA O TEXTO "PRESS SPACE TO START THE GAME" VISIVEL NOVAMENTE
		start_game_label.visible = true
		has_game_started = false
		
		#CHAMA A FUNÇÃO START DO TIMER QUE VAI CHAMAR A FUNÇÃO START_BALL QUANDO O TIMER ACABAR
		#start_ball_timer.start()

#MESMA COISA DO METODO ACIMA, ADICIONA 1 AO SCORE DO JOGADOR ,ATUALIZA O TEXT LABEL
#COM A NOVA PONTUAÇÃO
#RESETA A POSIÇÃO DA BOLA E INICIA O TIMER PRA COMEÇAR UMA NOVA PARTIDA
func _on_ball_enters_player_score_area(body):
	#NOVAMENTE UM IF STATEMENT PRA QUE SÓ A BOLA ATIVE A PONTUAÇÃO PARA O PLAYER
	if body.name == "Ball":
		#PLAYER SCORE RECEBE + 1 PONTO
		player_score += 1
		
		#ATUALIZA O TEXTO DO PLAYER SCORE LABEL
		player_score_label.text = str(player_score)
		
		
		#TRAZENDO A BOLA PARA O MEIO DA TELA E SETTANDO A VELOCIDADE PARA 0
		ball.ball_respawn()
		ball.ball_speed = 0
		
		#TORNA O TEXTO "PRESS SPACE TO START THE GAME" VISIVEL NOVAMENTE
		start_game_label.visible = true
		has_game_started = false
		
		#COMEÇA A CONTAR O TEMPO PRA POR A BOLA EM MOVIMENTO NOVAMENTE
		#start_ball_timer.start()



#QUANDO O TIMER TERMINA 
func _on_start_ball_timer_timeout():
	
	#VOLTA A VELOCIDADE DA BOLA PRA VELOCIDADE INICIAL E DÁ O "PONTAPÉ" PRA ELA VOLTAR A SE MEXER
	ball.ball_speed = 185
	ball.ball_respawn()
	
	


func _on_btn_back_to_main_menu_pressed():
	
	restart_the_game_state()
	get_tree().change_scene_to_file("res://Scenes/Menus/Main_Menu.tscn")

func restart_the_game_state():
	Global.gamemodePVE = false
	Global.gamemodePVP = false
	
	player_score = 0
	cpu_score = 0
	
	get_tree().paused = false
