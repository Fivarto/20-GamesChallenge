extends Node2D

@export var _enemy: PackedScene 
#@export var spawn_positions: Array[Marker2D]


func spawn_enemy():
	
	var enemy_instance = _enemy.instantiate()
	
	#enemy_instance.position = spawn_positions[randi_range(0,2)].position
	
	
	add_child(enemy_instance)



func _on_enemy_spawn_rate_timeout():
	spawn_enemy()
