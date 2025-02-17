extends Node2D

var timer: Timer

@export var _enemy: PackedScene 
#@export var spawn_positions: Array[Marker2D]

@export var _enemy_spawn_rate: float
@export var _enemy_spawn_cooldown: float

var enemies_on_screen : int = 0

func _ready() -> void:
	
	
	timer = Timer.new()
	timer.name = "Timer2Teste"
	add_child(timer)
	
	timer.wait_time = _enemy_spawn_rate
	timer.one_shot = false
	timer.timeout.connect(_on_Timer_timeout)
	timer.start()


func spawn_enemy():
	
	if enemies_on_screen < 3:
		enemies_on_screen += 1
		var enemy_instance = _enemy.instantiate()
		add_child(enemy_instance)
	elif enemies_on_screen == 3:
		enemies_on_screen = 0
		timer.stop()
		await get_tree().create_timer(_enemy_spawn_cooldown).timeout
		timer.start()

func _on_Timer_timeout():
	#SPAWNA INIMIGO
	#CONTA 3 INIMIGOS EM TELA
	#PARA O TIMER PELO TEMPO DE COOL DOWN
	#STARTA O TIMER DE NOVO
	
	spawn_enemy()
