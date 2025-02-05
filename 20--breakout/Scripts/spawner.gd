extends Node2D

@export var enemy_slime: PackedScene



func _ready():
	spawn_enemy()


func spawn_enemy():
	if enemy_slime:
		var enemy_instance = enemy_slime.instantiate()
		
		add_child(enemy_instance)
		
	else:
		print("Enemy not assigned")
