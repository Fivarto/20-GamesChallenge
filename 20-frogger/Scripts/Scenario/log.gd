extends Node2D

signal stick_to_log
signal get_of_the_log

var log_speed: float = 40

var _sticky: bool 

func _process(delta: float) -> void:
	
	position.x -= log_speed * delta
	
	
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	
	emit_signal("stick_to_log")


func _on_area_2d_area_exited(area: Area2D) -> void:
	
	emit_signal("get_of_the_log")
	
