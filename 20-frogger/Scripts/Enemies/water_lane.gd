extends Node2D
class_name WaterLane

const HALF_LOG_LENGTH = 8

@export var logs_length = [4, 4, 4]
@export var distance_between_logs = 180
@export var log_speed: float = 200
@export var movement_x_limit: float = 720
@export var movement_direction:int = 1


@onready var log_scene:PackedScene = preload("res://Scenes/Level/logs.tscn")

var logs: Array[Log] = []


func _ready() -> void:
	
	var index = 0
	
	var start_position_x = -movement_x_limit + logs_length[0] * HALF_LOG_LENGTH * -movement_direction
	
	
	for logs_length in logs_length:
		
		var log = log_scene.instantiate() as Log #INSTANCIANDO A CENA LOG
		log.middle_section_length = logs_length - 2 # 4 - 2 ?
		add_child(log)
		
		var previous_log_position = -movement_x_limit if index == 0 else logs[index - 1].position.x
		log.position.x = (logs_length * HALF_LOG_LENGTH + distance_between_logs) * - movement_direction + previous_log_position
		index += 1
		logs.append(log)



func _process(delta: float) -> void:
	
	
	for log in logs:
		var new_position_x = log_speed * delta * movement_direction + log.position.x
		if abs(new_position_x - movement_x_limit) < 10:
			log.position.x = -movement_x_limit
		
		else:
			log.position.x = new_position_x
