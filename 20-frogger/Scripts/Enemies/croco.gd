extends Area2D
class_name Turtle

@onready var turtle_sprite = $TurtleSprite
@onready var water_particles: CPUParticles2D = $WaterParticles


func set_sprite_rotation_dregrees(degrees):
	turtle_sprite.rotation_degrees = degrees
	
	if degrees == 0:
		water_particles.gravity = Vector2(250, 0)
	
	if degrees == 180:
		water_particles.position.x = water_particles.position.x - 32
		water_particles.gravity = Vector2(-250, 0)
