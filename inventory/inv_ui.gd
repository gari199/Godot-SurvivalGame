extends Control

#Hacemos el preload de nuestra resource. No muy claro qué es una resource.
@onready var inv: Inv = preload("res://inventory/player_inv.tres")

#Cojemos todos los nodos por debajo del NinePatchrect/GridContainer (Slots) y los metemos en un array.
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	#cuando el inventorio llama la senhal, se actualiza. MUY COMPLICADO
	inv.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())): #Go through all the slots we have
		slots[i].update(inv.slots[i]) #Para slot[0], meterá item[1] y así sucesivamente???

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
