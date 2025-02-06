extends StaticBody2D

@export var block_life: int = 3
@export var texture_sprite: Array[SpriteFrames] = []

@onready var sprite_array_test = $SpriteArrayTest
@onready var particles = $Particles



func _ready():
	sprite_array_test.sprite_frames = texture_sprite[randi_range(0, 2)]
	sprite_array_test.play("default")

func get_damaged():
	
	particles.emitting = true
	
	block_life -= 1
	
	if block_life >= 1:
		Global.player_current_score += 1
		print(Global.player_current_score)
		
		
	else:
		queue_free()
		
	particles.emitting = false
