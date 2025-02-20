extends Area2D
class_name Turtle

@onready var turtle_sprite = $TurtleSprite


func set_sprite_rotation_dregrees(degrees):
	turtle_sprite.rotation_degrees = degrees
