extends Node2D
class_name Log

# CONSTANTE QUE GUARDA O TAMANHO DE CADA SEÇÃO DO TRONCO
const  LOG_SECTION_LENGTH = 16


# DEFINE O TAMANHO DA SEÇÃO DO MEIO | DO TRONCO 
@export var middle_section_length:int = 3

#PEGA AS CENAS PRA MONTAR O LOG
@onready var log_start_scene: PackedScene = preload("res://Scenes/Level/Logs/log_start.tscn")
@onready var log_middle_scene: PackedScene = preload("res://Scenes/Level/Logs/log_middle.tscn")
@onready var log_end_scene: PackedScene = preload("res://Scenes/Level/Logs/log_end.tscn")

#DEFINE A VELOCIDADE DO TRONCO
@export var log_speed: float


func _ready() -> void:
	
	var log_start = log_start_scene.instantiate() #INSTANCIANDO O PRIMEIRO PEDAÇO
	
	add_child(log_start) # ADICIONA O PRIMEIRO "BLOCO"
	
	# POSIÇÃO DO PRIMEIRO TRONCO
	var log_start_x = -middle_section_length / 2 - LOG_SECTION_LENGTH / 2 # (-3 / 2) - (16 / 2) = -9
	log_start.position.x = log_start_x #SETOU A POSICÃO DO LOG START
	
	#LOOP PARA SPAWNAR AS SESSÕES DO MEIO DO LOG
	for i in middle_section_length: # PARA I EM 3:
		var log_middle = log_middle_scene.instantiate() #INSTANCIANDO LOG MIDDLE SCENE
		
		add_child(log_middle) # ADICIONA O LOG MIDDLE NA TREE
		
		#A POSIÇÃO DO TRONCO DO MEIO VAI SER -9()
		log_middle.position.x = log_start_x + (i + 1) * LOG_SECTION_LENGTH # -9 + ( 0 | 1 | 2 + 1) * 16
		
	
	#SPAWNAR O ULTIMO PEDAÇO DO LOG
	var log_end = log_end_scene.instantiate()
	
	add_child(log_end)
	
	#  -9|START POSITION| + (16 * 3)|MIDDLE POSITIONS| + (16 / 2) |LAST POSITION|
	var log_end_position = log_start_x + LOG_SECTION_LENGTH * middle_section_length + LOG_SECTION_LENGTH / 2
	log_end.position.x = log_end_position
