extends Control


func _on_button_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")


func _on_button_quit_game_pressed():
	get_tree().quit()
