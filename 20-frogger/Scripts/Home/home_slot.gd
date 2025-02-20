extends Area2D
class_name HomeSlot

signal capy_entered_home

@onready var capy_in_home = $CapyInHome



func _on_area_entered(area):
	
	if area is Player:
		capy_entered_home.emit()
		capy_in_home.visible = true
