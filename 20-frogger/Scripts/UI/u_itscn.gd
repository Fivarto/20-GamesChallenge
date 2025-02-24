extends CanvasLayer
class_name UI

signal timer_runs_out

const TIME_LIMIT: float = 180

#HUD CONTAINER
@onready var lifes_container = %LifesContainer
@onready var timeout_timer = $TimeoutTimer
@onready var timer_progress_bar = %TimerProgress

var life_texture: Texture2D = preload("res://Assets/UI/life_texture.png")
var lifes_textures: Array[TextureRect] = []

#WIN | LOST SCREENS
@onready var center_container = $MarginContainer/WinLoseScreen
#@onready var game_result_title = %GameResultTitle
@onready var panel_container =  $MarginContainer/WinLoseScreen/PanelContainer
@onready var win_screen = $MarginContainer/WinLoseScreen/PanelContainer/WinScreen
@onready var lose_screen = $MarginContainer/WinLoseScreen/PanelContainer/LoseScreen


#PLAYER TIMER
var current_player_time: float
var player_total_time: float
@onready var time_score_lable: Label = $MarginContainer/WinLoseScreen/VBoxContainer/TimeScoreLable


#INSTRUCTIONS VARIABLES
@onready var instrution_label: Label = $Instrutions/InstrutionLabel
@onready var instruction_timer: Timer = $Instrutions/InstructionTimer


func _ready():
	
	timeout_timer.timeout.connect(on_timeout)
	
	instruction_timer.start()



#TIMER CONTAINER
func on_timeout():
	var new_progress_bar_value = timer_progress_bar.value - 1
	
	#DIMINUI O TEMPO NA PROGRESS BAR
	timer_progress_bar.set_value(new_progress_bar_value)
	
	current_player_time = TIME_LIMIT - new_progress_bar_value
	
	if new_progress_bar_value == 0:
		print("Acabou o tempo , recomeçar a barra de tempo")
		
		timer_runs_out.emit()
		timeout_timer.stop()
		

func reset_timer():
	
	player_total_time += current_player_time
	
	current_player_time = 0
	
	timer_progress_bar.set_value(TIME_LIMIT)
	timeout_timer.start()



#LIFE CONTAINER
func set_life_amount(lives_amount: int):
	
	for i in lives_amount:
		
		var life_texture_rect = TextureRect.new()
		life_texture_rect.custom_minimum_size = Vector2 (16, 16)
		life_texture_rect.texture = life_texture
		
		lifes_container.add_child(life_texture_rect)
		lifes_textures.append(life_texture_rect)

#ATUALIZAR OS SCPRITES DE LIFE
func lose_life():
	
	var texture_life = lifes_textures.pop_back()
	
	texture_life.queue_free()


#WIN | LOSE UI 
func show_you_lose_ui():
	timeout_timer.stop()
	time_score_lable.text = ("Time: " + str(player_total_time) + "s")
	#game_result_title.text = "YOU LOST! :("
	lose_screen.visible = true
	center_container.show()


func show_you_won_ui():
	timeout_timer.stop()
	#game_result_title.text = "YOU WON! CONGRATULATIONS"
	player_total_time += current_player_time
	time_score_lable.text = ("Time: " + str(player_total_time) + "s")
	win_screen.visible = true
	center_container.show()


func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_instruction_timer_timeout() -> void:
	
	instrution_label.visible = false
	timeout_timer.start()
