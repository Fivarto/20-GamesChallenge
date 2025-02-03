extends Control

@onready var tab_container = $TabContainer
@onready var btn_exit_options = $btn_exit_options
@onready var game_mode_menu = $game_mode_menu
@onready var main_menu_container = $main_menu_container

@onready var player_1_color_picker = $"TabContainer/Paddle Color/player_1_color_picker"
@onready var player_2_color_picker = $"TabContainer/Paddle Color/player_2_color_picker"

@onready var label_color_1 = $"TabContainer/Paddle Color/player_1_color_picker_label"
@onready var label_color_2 = $"TabContainer/Paddle Color/player_1_color_picker_label2"


#			 -----MAIN MENU -------

#		ESCOLHER GAME MODE

func _on_btn_start_game_pressed():
	
	main_menu_container.visible = false
	game_mode_menu.visible = true

# START GAME PLAYER VS CPU
func _on_btn_pve_pressed():
	
	Global.gamemodePVE = true
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")

# START GAME PLAYER VS PLAYER
func _on_btn_pvp_pressed():
	
	Global.gamemodePVP = true
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")

func _on_btn_controls_pressed():
	
	tab_container.visible = true
	btn_exit_options.visible = true

#SAINDO DO JOGO
func _on_btn_exit_pressed():
	get_tree().quit()

# ----- OPTIONS  -------


func _on_btn_exit_options_pressed():
	tab_container.visible = false
	btn_exit_options.visible = false

#PLAYER 1 COLOR PICKER
func _on_player_1_color_picker_color_changed(color):
	
	label_color_1.modulate = color
	
	Global.player_1_color = player_1_color_picker.color
	

#PLAYER 2 COLOR PICKER
func _on_player_2_color_picker_color_changed(color):
	
	label_color_2.modulate = color
	
	Global.player_2_color = player_2_color_picker.color
	

# -----GAME MODE MENU -------

func _on_btn_back_to_menu_pressed():
	
	main_menu_container.visible = true
	game_mode_menu.visible = false


#BUTTON SOUNDS

func play_button_sound():
	$button_sfx.pitch_scale = randf_range(0.9 , 1.1)
	$button_sfx.play()

#MAIN MENU
func _on_btn_start_game_mouse_entered():
	play_button_sound()

func _on_btn_controls_mouse_entered():
	play_button_sound()

func _on_btn_exit_mouse_entered():
	play_button_sound()

#OPTIONS MENU
func _on_btn_exit_options_mouse_entered():
	play_button_sound()

#GAMEMODE MENU
func _on_btn_pve_mouse_entered():
	play_button_sound()

func _on_btn_pvp_mouse_entered():
	play_button_sound()

func _on_btn_back_to_menu_mouse_entered():
	play_button_sound()
