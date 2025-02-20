extends Node2D

@onready var player: CharacterBody2D = %Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var camera_animation: AnimationPlayer = $Camera2D/CameraAnimation

var isInWaterLevel: bool = false

var sticky_to_log: bool = false

func _ready() -> void:
	
	player.connect("player_hit" , Callable(self, "_on_player_hit"))
	player.connect("drowning" , Callable(self, "on_player_drowning"))
	
	get_tree().get_nodes_in_group("moveable")[0].connect("stick_to_log", Callable(self, "player_on_board"))
	get_tree().get_nodes_in_group("moveable")[0].connect("get_of_the_log", Callable(self, "player_of_board"))

func _process(delta):
	
	if sticky_to_log == true:
		player.position = get_tree().get_nodes_in_group("moveable")[0].position


func on_player_drowning():
	
	isInWaterLevel = false
	
	camera_animation.play("stree_level_transition")



func player_on_board():
	
	sticky_to_log = true
	
	print("LOG SINAL CONNECTED")

func player_of_board():
	sticky_to_log = false
	player.position.y -= 36
	print("LOG OFF")

#CAMERA POSITION CHANGES
func _on_water_level_transition_area_entered(area: Area2D) -> void:
	isInWaterLevel = true
	camera_animation.play("water_level_transition")


func _on_street_level_transition_area_entered(area: Area2D) -> void:
	if isInWaterLevel == true:
		camera_animation.play("stree_level_transition")
