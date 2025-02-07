extends StaticBody2D

@export var block_life: int = 3
@export var texture_sprite: Array[SpriteFrames] = []

@onready var sprite_array_test = $SpriteArrayTest
@onready var particles = $Particles

@onready var hurt_sound = $HurtSound


func _ready():
	sprite_array_test.sprite_frames = texture_sprite[randi_range(0, 2)]
	sprite_array_test.play("default")

func get_damaged():
	
	particles.emitting = true
	block_life -= 1
	
	if block_life >= 1:
		hurt_sound.play()
		Global.player_current_score += 1
		
		
	else:
		
		hurt_sound.play()
		await hurt_sound.finished
		
		Global.enemies_on_screen -= 1
		queue_free()
		
