extends StaticBody2D

@export var block_life: int = 3

@export var texture_sprite: Array[Texture] = []

@onready var sprite_array_test = $SpriteArrayTest


func _ready():
	sprite_array_test.texture = texture_sprite[randi_range(0, 2)]

func get_damaged():
	
	block_life -= 1
	
	if block_life >= 1:
		Global.player_current_score += 1
		print(Global.player_current_score)
	else:
		queue_free()
