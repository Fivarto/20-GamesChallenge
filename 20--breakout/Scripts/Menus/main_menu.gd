extends Control

@onready var button_play: Button = $VBoxContainer/ButtonPlay
@onready var button_play_sprite: AnimatedSprite2D = $VBoxContainer/ButtonPlay/ButtonPlaySprite

@onready var button_exit: Button = $VBoxContainer/ButtonExit
@onready var button_exit_sprite: AnimatedSprite2D = $VBoxContainer/ButtonExit/ButtonExitSprite


func _on_button_play_pressed() -> void:
	button_play_sprite.play("default")
	await button_play_sprite.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")



func _on_button_exit_pressed() -> void:
	
	button_exit_sprite.play("default")
	await button_exit_sprite.animation_finished
	get_tree().quit()
	
