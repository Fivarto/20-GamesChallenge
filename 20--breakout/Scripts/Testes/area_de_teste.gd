extends Node2D

@export var enemy_scene: PackedScene

@export var enemy_spawn_position: Marker2D

func _input(event):
	
	if Input.is_key_pressed(KEY_SPACE):
		spawn_enemy()


func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	
	if enemy_spawn_position:
		enemy_instance.position = enemy_spawn_position.global_position
	
	else:
		enemy_instance.position = Vector2(get_viewport().size/2)
	
	add_child(enemy_instance)
