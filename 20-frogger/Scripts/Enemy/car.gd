extends Node2D

var car_speed: float = 130

func _process(delta):
	
	position.x -= car_speed * delta




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
