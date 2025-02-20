extends Node2D
class_name TurtleSection

const TURTLE_SIZE:int = 32

@onready var turtle_scene: PackedScene = preload("res://Scenes/Enemies/croco.tscn")

@export var turtle_count: int = 3
@export var movement_direction: int = 1

func _ready():
	
	var section_length = get_section_length()
	
	for i in turtle_count:
		var turtle = turtle_scene.instantiate() as Turtle
		
		add_child(turtle)
		
		if movement_direction == 1:
			
			turtle.set_sprite_rotation_dregrees(180)
		
		turtle.position.x = TURTLE_SIZE / 2 - TURTLE_SIZE * i


func get_section_length():
	return turtle_count * TURTLE_SIZE
