extends Node2D
class_name HighwayLane

signal player_hit_by_car

@onready var vehicle_scene: PackedScene = preload("res://Scenes/Enemies/vehicle.tscn")

#1 = DA ESQUERDA PRA DIREITA | -1 = DA DIREITA PRA ESQUERDA
@export var direction: int = 1
@export var vehicle_texture: Texture2D
@export var vehicle_count: int = 3
@export var distance_between_vehicles = 100
@export var vehicles_speed: float = 200
@export var movement_x_limit: float = 352
@export var vehicle_collision_size: Vector2 = Vector2(10, 10)

var vehicles: Array = []

func _ready() -> void:
	
	var start_point_x = movement_x_limit * direction
	
	for i in vehicle_count:
		var vehicle = vehicle_scene.instantiate() as Vehicle
		vehicle.position = Vector2(-movement_x_limit + distance_between_vehicles * i * -direction, 0)
		vehicle.area_entered.connect(on_player_hit_by_vehicle)
		
		add_child(vehicle)
		vehicle.set_vehicle_texture(vehicle_texture)
		vehicle.get_node("VehicleCollision").shape.size = vehicle_collision_size
		
		if direction == 1:
			vehicle.get_node("VehicleSprite").flip_h = true
		
		elif direction == -1:
			
			vehicle.get_node("VehicleSprite").flip_h = false
		
		vehicles.append(vehicle)


func _process(delta: float) -> void:
	
	for vehicle in vehicles:
		var new_position_x = vehicles_speed * delta * direction + vehicle.position.x
		
		if abs(new_position_x - movement_x_limit) < 10:
			
			vehicle.position.x = -movement_x_limit
			
		else:
			vehicle.position.x = new_position_x


func on_player_hit_by_vehicle(area: Area2D):
	print("Player hitted")
	
	if area is Player:
		player_hit_by_car.emit() #SIGNAL NESSE SCRIPT
	
