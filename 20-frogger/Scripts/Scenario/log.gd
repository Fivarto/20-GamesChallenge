extends Node2D

var log_speed: float = 40

func _process(delta: float) -> void:
	
	position.x -= log_speed * delta
