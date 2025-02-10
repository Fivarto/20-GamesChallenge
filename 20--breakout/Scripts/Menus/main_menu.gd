extends Control

@onready var button_play: Button = $VBoxContainer/ButtonPlay
@onready var button_play_sprite: AnimatedSprite2D = $VBoxContainer/ButtonPlay/ButtonPlaySprite

@onready var button_exit: Button = $VBoxContainer/ButtonExit
@onready var button_exit_sprite: AnimatedSprite2D = $VBoxContainer/ButtonExit/ButtonExitSprite

@onready var sfx_button_click = $VBoxContainer/SFXButtonClick


#BOTÃO PLAY
func _on_button_play_pressed() -> void:
	button_play_sprite.play("default")
	await button_play_sprite.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main_level.tscn")


#QUANDO O MOUSE PASSA POR CIMA VAI PARA O FRAME 1
func _on_button_play_mouse_entered():
	button_play_sprite.frame = 1
	sfx_button_click.pitch_scale = randf_range(0.8 , 1.2)
	sfx_button_click.play()
#QUANDO O MOUSE SAI DE CIMA VOLTA AO FRAM 0
func _on_button_play_mouse_exited():
	button_play_sprite.frame = 0



#BOTÃO EXIT
func _on_button_exit_pressed() -> void:
	
	button_exit_sprite.play("default")
	await button_exit_sprite.animation_finished
	get_tree().quit()
	

#QUANDO O MOUSE PASSAR EM CIMA VAI AO FRAME 1
func _on_button_exit_mouse_entered():
	sfx_button_click.pitch_scale = randf_range(0.8 , 1.2)
	sfx_button_click.play()
	button_exit_sprite.frame = 1

#QUANDO O MOUSE SAI DE CIMA DO BOTÃO , VOLTA AO FRAME 0
func _on_button_exit_mouse_exited():
	button_exit_sprite.frame = 0
