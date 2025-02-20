extends Node2D
class_name Log

const  LOG_SECTION_LENGTH = 16


@export var middle_section_length:int = 3

@onready var log_start_scene: PackedScene = preload("res://Scenes/Level/Logs/log_start.tscn")
@onready var log_middle_scene: PackedScene = preload("res://Scenes/Level/Logs/log_middle.tscn")
@onready var log_end_scene: PackedScene = preload("res://Scenes/Level/Logs/log_end.tscn")

var log_speed


func _ready() -> void:
	
	var log_start = log_start_scene.instantiate() #INSTANCIANDO O PRIMEIRO PEDAÇO
	
	add_child(log_start)
	
	var log_start_x = -middle_section_length / 2 - LOG_SECTION_LENGTH / 2 # (3 / 2) - (16 / 2)
	
	log_start.position.x = log_start_x #SETOU A POSICÃO DO LOG START
	
	#LOOP PARA SPAWNAR AS SESSÕES DO MEIO DO LOG
	for i in middle_section_length:
		var log_middle = log_middle_scene.instantiate() #INSTANCIANDO LOG MIDDLE SCENE
		
		add_child(log_middle) # ADICIONA O LOG MIDDLE NA TREE
		
		log_middle.position.x = log_start_x + (i + 1) * LOG_SECTION_LENGTH
	
	#SPAWNAR O ULTIMO PEDAÇO DO LOG
	var log_end = log_end_scene.instantiate()
	
	add_child(log_end)
	
	#  log_start_x + (16 * 3) + (16 / 2)
	var log_end_position = log_start_x + LOG_SECTION_LENGTH * middle_section_length + LOG_SECTION_LENGTH / 2
	log_end.position.x = log_end_position
