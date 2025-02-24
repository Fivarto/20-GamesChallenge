extends Node

@onready var player = $"../Player" as Player
@onready var home_slots = $"../HomeSlots" as HomeSlots
@onready var ui = $"../UI" as UI

@onready var highway_lanes = $"../HighwayLanes"
@onready var water_lanes = $"../WaterLanes"

func _ready():
	
	home_slots.all_home_slots_full.connect(on_all_home_slots_filled)
	home_slots.one_home_slot_filled.connect(on_one_home_slots_filled)
	
	player.life_lost.connect(on_player_lost_a_life)
	player.game_over.connect(on_game_over)
	
	
	ui.timer_runs_out.connect(kill_player)
	
	ui.start_the_game.connect(turn_on_the_game)
	ui.set_life_amount(player.lifes)


func on_player_lost_a_life():
	#print("PLAYER PERDEU UMA VIDA")
	
	ui.reset_timer()
	ui.lose_life()

func kill_player():
	#print("PLAYER DIED")
	
	player.die()

func on_one_home_slots_filled():
	#print("CAPIVARA CHEGOU EM CASA")
	
	player.reset_player()

func on_all_home_slots_filled():
	#print("PLAYER WIN")
	
	ui.show_you_won_ui()
	
	player.reset_player()


func on_game_over():
	#print("GAME OVER")
	
	ui.show_you_lose_ui()
	

func turn_on_the_game():
	
	highway_lanes.process_mode = 0
	water_lanes.process_mode = 0
	
	player.set_process_input(true)
