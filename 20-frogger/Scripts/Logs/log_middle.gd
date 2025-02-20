extends Area2D


var player_on_log: Area2D = null


func _on_area_entered(area):
	print("ENTROU NA AREA DO TRONCO")
	
	if player_on_log is Player:
		player_on_log = area

func _on_area_exited(area):
	print("SAIU NA AREA DO TRONCO")
	
	if player_on_log is Player:
		player_on_log = null
