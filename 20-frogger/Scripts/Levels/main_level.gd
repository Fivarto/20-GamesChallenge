extends Node2D

@onready var player: CharacterBody2D = %Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var camera_animation: AnimationPlayer = $Camera2D/CameraAnimation

var isInWaterLevel: bool = false

func _ready() -> void:
	
	player.connect("player_hit" , Callable(self, "_on_player_hit"))
	



func _on_player_hit():
	
	#player.queue_free()
	
	print("Player Eliminado")



#CAMERA POSITION CHANGES
func _on_water_level_transition_area_entered(area: Area2D) -> void:
	isInWaterLevel = true
	camera_animation.play("water_level_transition")


func _on_street_level_transition_area_entered(area: Area2D) -> void:
	if isInWaterLevel == true:
		camera_animation.play("stree_level_transition")
