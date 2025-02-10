extends Node2D

@export var enemy_slime: PackedScene
@export var enemy_position_list: Array[Marker2D]


func _ready():
	spawn_enemy()
	#if Global.enemies_on_screen <= Global.max_enemies_on_level:
	#	spawn_enemy()

func _process(delta: float) -> void:
	pass
	#if Global.enemies_on_screen <= Global.max_enemies_on_level:
	#	spawn_enemy()


func spawn_enemy():
	
	Global.enemies_on_screen += 1
	
	if enemy_slime:
		
		for i in range(Global.max_enemies_on_level):
			
			var enemy_instance = enemy_slime.instantiate()
			
			enemy_instance.position = enemy_position_list[i].position
			#print(enemy_position_list.size())
			#print(enemy_position_list[1].position)
			#print(i)
			
			add_child(enemy_instance)
			
	
	elif Global.enemies_on_screen == Global.max_enemies_on_level:
		print("Wave Full")
	
	else:
		print("Enemy not assigned")
