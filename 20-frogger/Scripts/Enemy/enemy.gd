extends Node2D


@export var vehicle_status : Resource

func _ready():
	pass

func _process(delta):
	
	if vehicle_status.enemy_direction == 1:
		position.x -= vehicle_status.enemy_speed * delta
	
	if vehicle_status.enemy_direction == -1:
		position.x += vehicle_status.enemy_speed * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_danger_zone_body_entered(body: Node2D) -> void:
	print("Bateu")
