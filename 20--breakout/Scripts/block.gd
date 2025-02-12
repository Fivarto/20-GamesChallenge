extends StaticBody2D

@export var block_life: int = 3
@export var texture_sprite: Array[SpriteFrames] = []

@onready var sprite_array_test = $SpriteArrayTest
@onready var particles = $Particles

@onready var hurt_sound = $HurtSound


func _ready():
	#SE ADICIONA AO GRUPO INIMIGOS PRA SER USADO EM OUTRO SCRIPT
	self.add_to_group("inimigos")
	#PEGA UM SPRITE ALEATORIO ENTRE OS 3 MODELOS DE SLIME
	sprite_array_test.sprite_frames = texture_sprite[randi_range(0, 2)]
	#TOCA A ANIMAÇÃO DO SPRITE
	sprite_array_test.play("default")



#INIMIGO LEVA DANO
func get_damaged():
	
	#EMITI PARTICULAS PRA DEMONSTRAR O DANO
	particles.emitting = true
	#DIMINUI 1 DA VIDA DO INIMIGO
	block_life -= 1
	
	#SE TIVER PELO MENOS 1 DE VIDA , ENTRA
	if block_life > 0:
		hurt_sound.pitch_scale = randf_range(0.5 , 1.1)
		hurt_sound.play()
		Global.player_current_score += 1
		
	#QUANDO CHEGAR NO 0 DE VIDA
	else:
		#TOCA O SOM "DE MORTE"
		Global.player_current_score += 1
		hurt_sound.play()
		await hurt_sound.finished #ESPERA ACABAR O SOM
		
		Global.enemies_on_screen -= 1 #DIMINUI 1 DA VARIAVEL GLOBAL INIMIGOS EM TELA
		queue_free() #"DESTROI" O INIMIGO 
