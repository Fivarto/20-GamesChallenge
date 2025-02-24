extends CanvasLayer


func _on_transition_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level/main_scene.tscn")
