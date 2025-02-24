extends Area2D
class_name Player

signal life_lost
signal game_over

const PLAYER_SPAWN_POSITION = Vector2 (176, 432)
const POSITION_INCREMENT: float = 32

var new_position: Vector2 = Vector2.ZERO

@export var speed: float = 40
@export var lifes: int = 3

var screen_bounds = {
	
	"left": 0,
	"right": 0,
	"bottom": 0
	
}

var ui_size: float = 32

#LOG CARRY VARS
var carry_capy_speed: float
var is_being_carried: bool = false

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_animation: AnimationPlayer = $PlayerAnimation
@onready var player_collision = $PlayerCollision
@onready var log_detector_collision: CollisionShape2D = $LogDetector/LogDetectorCollision

@onready var death_particles: CPUParticles2D = $DeathParticles



@onready var death_timer = $DeathTimer

func _ready() -> void:
	
	#DEFINE AS BORDAS DA TELA PARA QUE A CAPY NÃO POSSA SAIR DA TELA
	screen_bounds.left = 0
	screen_bounds.right = get_viewport().size.x
	screen_bounds.bottom = get_viewport().size.y - ui_size
	
	#CONECTA COM O SINAL DE FINALIZAÇÃO DE TEMPO DO TIMER, CASO O TEMPO ACABE, ELIMINA O PLAYER
	death_timer.timeout.connect(on_death_timer_timeout)

func _process(delta: float) -> void:
	
	
	if new_position == Vector2.ZERO:
		#position.x += 80 * delta
		return
	
	# SE O PLAYER SAIR DA TELA | MORRE
	if position.x < screen_bounds.left or position.x > screen_bounds.right:
		die()
	
	#QUANDO ENTRA EM CONTATO COM LOG OU TURTLE, É CARREGADO
	#ADICIONANDO UM "IMPULSO" EQUIVALENTE A VELOCIDADE MOVIMENTO DO LOG OU DA TURTLE(ESSAS 2 VARIAVEIS SÃO DEFINIDAS EM WATERLANE E CROCO LANE)
	elif is_being_carried == true:
		position.x += carry_capy_speed * delta
		return
	
	#SUAVIZA A MOVIMENTAÇÃO ENTRE A POSIÇÃO ATUAL E A NOVA POSIÇÃO
	#1º VALOR = POSIÇÃO ATUAL | 2º POSIÇÃO PARA ONDE O PLAYER VAI | 3º VELOCIDADE DE TRANSIÇÃO ENTRE AS POSIÇÕES
	position = lerp(position , new_position, speed * delta)
	
	
	
	if absf((position - new_position).length()) < 0.001:
		
		position = round(position)
		
		var overllaping_areas = get_overlapping_areas()
		
		#SE NÃO ESTIVER OVERLLAPING NADA , NADA ACONTECE
		if overllaping_areas.size() == 0:
			return
		#SE "OVERLAPIAR" APENAS AGUA, MORRE 
		elif !overllaping_areas.any(func(area): return !(area is Water)):
			die()
		
		
	else:
		player_animation.play("walk")



func _input(event: InputEvent) -> void:
	
	var position_candidate
	
	
	#EM TODOS OS MOVIMENTOS SETEI A VAR is_being_carried PARA FALSO PARA QUE A CAPY CONSIGA SAIR DO TRONCO
	if Input.is_action_just_pressed("UP"):
		is_being_carried = false 
		position_candidate = Vector2.UP * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 0
		
	elif Input.is_action_just_pressed("DOWN"):
		is_being_carried = false
		position_candidate = Vector2.DOWN * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 180
		
	elif Input.is_action_just_pressed("LEFT"):
		is_being_carried = false
		position_candidate = Vector2.LEFT * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = -90
		
	elif Input.is_action_just_pressed("RIGHT"):
		is_being_carried = false
		position_candidate = Vector2.RIGHT * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 90
	
	
	if !position_candidate:
		return
	
	#CONFINAR O PLAYER DENTRO DA TELA
	if position_candidate.x < screen_bounds.left or position_candidate.x > screen_bounds.right or position_candidate.y > screen_bounds.bottom - 16:
		return
	
	
	new_position = position_candidate


func die():
	
	#PARAR/ "DESATIVAR" O PLAYER
	set_process_input(false)
	player_collision.set_deferred("disabled", true)
	log_detector_collision.set_deferred("disabled", true)
	player_animation.stop()
	death_particles.emitting = true
	player_sprite.visible = false
	is_being_carried = false
	
	death_timer.start()

func reset_player():
	set_process_input(true)
	player_collision.set_deferred("disabled", false)
	log_detector_collision.set_deferred("disabled", false)
	player_sprite.visible = true
	
	global_position = PLAYER_SPAWN_POSITION
	new_position = PLAYER_SPAWN_POSITION



func on_death_timer_timeout():
	
	lifes -= 1
	
	life_lost.emit()
	
	if lifes == 0:
		game_over.emit()
	else:
		reset_player()


func _on_log_detector_area_entered(area):
	
	
	
	await get_tree().create_timer(0.05).timeout
	
	position = round(position)
	
	
	if area.get_parent().get_parent().is_in_group("log"):
		
		carry_capy_speed = area.get_parent().get_parent().log_speed * area.get_parent().get_parent().movement_direction
		is_being_carried = true
		
	if area.get_parent().get_parent().is_in_group("turtle"):
		carry_capy_speed = area.get_parent().get_parent().turtle_speed * area.get_parent().get_parent().movement_direction
		is_being_carried = true

func _on_log_detector_area_exited(area):
	
	
	
	is_being_carried = false
	
