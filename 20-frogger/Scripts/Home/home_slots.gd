extends Node
class_name  HomeSlots

signal all_home_slots_full
signal one_home_slot_filled

var home_slots_count: int = 0
var full_slots:int = 0


func _ready():
	
	var home_slots = get_children() as Array[HomeSlot]
	
	home_slots_count = home_slots.size()
	
	for home_slot in home_slots:
		home_slot.capy_entered_home.connect(on_capy_enters_home)
		



#FUNCÃO ATIVADA QUANDO CAPIVARA ENTRA NA CASA
func on_capy_enters_home():
	full_slots += 1
	
	one_home_slot_filled.emit()
	
	if full_slots == home_slots_count:
		all_home_slots_full.emit()
