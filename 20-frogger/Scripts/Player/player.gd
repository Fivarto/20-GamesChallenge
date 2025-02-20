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


@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_animation: AnimationPlayer = $PlayerAnimation
@onready var player_collision = $PlayerCollision

@onready var death_timer = $DeathTimer

func _ready() -> void:
	
	screen_bounds.left = 0
	screen_bounds.right = get_viewport().size.x
	screen_bounds.bottom = get_viewport().size.y
	
	death_timer.timeout.connect(on_death_timer_timeout)

func _process(delta: float) -> void:
	
	if new_position == Vector2.ZERO:
		return
	
	
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
	
	
	if Input.is_action_just_pressed("UP"):
		position_candidate = Vector2.UP * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 0
		
	elif Input.is_action_just_pressed("DOWN"):
		position_candidate = Vector2.DOWN * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 180
		
	elif Input.is_action_just_pressed("LEFT"):
		position_candidate = Vector2.LEFT * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = -90
		
	elif Input.is_action_just_pressed("RIGHT"):
		position_candidate = Vector2.RIGHT * POSITION_INCREMENT + position
		player_sprite.rotation_degrees = 90
		
	
	if !position_candidate:
		return
	
	if position_candidate.x < screen_bounds.left or position_candidate.x > screen_bounds.right or position_candidate.y > screen_bounds.bottom - 16:
		return
	
	
	new_position = position_candidate


func die():
	
	#PARAR/ "DESATIVAR" O PLAYER
	set_process_input(false)
	player_collision.set_deferred("disabled", true)
	player_animation.stop()
	player_sprite.visible = false
	
	death_timer.start()

func reset_player():
	set_process_input(true)
	player_collision.set_deferred("disabled", false)
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
