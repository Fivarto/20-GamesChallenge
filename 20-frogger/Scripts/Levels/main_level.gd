extends Node2D

@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	
	player.connect("player_hit" , Callable(self, "_on_player_hit"))
	



func _on_player_hit():
	
	#player.queue_free()
	
	print("Player Eliminado")
