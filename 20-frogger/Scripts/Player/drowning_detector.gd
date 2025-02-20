extends Node2D

signal drowned

var water_collision: int = 0
var wasDrowningLastFrame: bool = false


func _process(delta):
	
	print(water_collision)
	
	var isDrowning = water_collision > 0
	
	if isDrowning && !wasDrowningLastFrame:
		drowned.emit() 
	
	wasDrowningLastFrame = isDrowning


func _on_water_detector_body_entered(body):
	water_collision += 1


func _on_water_detector_body_exited(body):
	water_collision -= 1 
