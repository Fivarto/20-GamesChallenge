extends Node2D

var log_speed: float = 40

func _process(delta: float) -> void:
	
	position.x -= log_speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Algo interagiu com o tronco")


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("Parou de interagir")
