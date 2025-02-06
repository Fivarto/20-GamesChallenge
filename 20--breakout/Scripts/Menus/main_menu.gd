extends Control

@onready var bt_start_game = $VBoxContainer/BTStartGame
@onready var bt_options = $VBoxContainer/BTOptions
@onready var bt_exit = $VBoxContainer/BTExit


func _on_bt_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")


func _on_bt_exit_pressed():
	get_tree().quit()
