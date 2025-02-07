extends Node2D

@export var enemy_slime: PackedScene



func _ready():
	
	if Global.enemies_on_screen <= Global.max_enemies_on_level:
		spawn_enemy()


func spawn_enemy():
	
	Global.enemies_on_screen += 1
	
	if enemy_slime:
		var enemy_instance = enemy_slime.instantiate()
		
		add_child(enemy_instance)
		
	else:
		print("Enemy not assigned")


func _on_next_level_wave_timeout():
	print("Timer")
	spawn_enemy()
