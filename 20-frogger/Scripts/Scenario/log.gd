extends StaticBody2D

var log_speed: float = 80

func _process(delta: float) -> void:
	
	position.x -= log_speed * delta
