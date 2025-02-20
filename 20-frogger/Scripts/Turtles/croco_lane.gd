extends Node2D
class_name TurtleLane

@onready var turtle_scene:PackedScene = preload("res://Scenes/Enemies/Turtles/turtle_section.tscn")

const HALF_TURTLE_SIZE: int = 16 

@export var turtle_sections_lenght = [3, 3, 4]
@export var distance_between_turtle_sections = 180
@export var turtle_speed: float = 200
@export var movement_x_limit: float = 720
@export var movement_direction:int = 1


var turtle_sections: Array = []


func _ready():
	
	var index = 0
	var section_starting_position_x = -movement_x_limit + turtle_sections_lenght[0] * HALF_TURTLE_SIZE * -movement_direction
	
	
	for section_length in turtle_sections_lenght:
		
		var turtle_sections_inst = turtle_scene.instantiate() as TurtleSection
		
		turtle_sections_inst.turtle_count = section_length
		turtle_sections_inst.movement_direction = movement_direction
		
		add_child(turtle_sections_inst)
		
		var previous_turtle_section_position = -movement_x_limit if index == 0 else turtle_sections[index - 1].position.x
		
		var previous_section_lenght = 0 if index == 0 else turtle_sections[ index - 1].get_section_length() / 2
		
		turtle_sections_inst.position.x = previous_turtle_section_position + (distance_between_turtle_sections + previous_section_lenght + section_length * HALF_TURTLE_SIZE) * -movement_direction
		turtle_sections.append(turtle_sections_inst)
		index +=1


func _process(delta):
	
	for turtle_section in turtle_sections:
		
		var new_position_x = turtle_speed * delta * movement_direction + turtle_section.position.x
		
		if abs(new_position_x - movement_x_limit) < 10:
			turtle_section.position.x = -movement_x_limit
		else:
			turtle_section.position.x = new_position_x
