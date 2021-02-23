extends Node2D



var inventory = {}

func _ready():
	inventory["hp_potion"] = 999
	inventory["chicken_wings"] = 23



func add_item(new_item, received_ammount):
	var existing_ammount 
	
	
	if new_item in inventory:
		existing_ammount = inventory[new_item]
		inventory[new_item] = existing_ammount + received_ammount
	else:
		inventory[new_item] = received_ammount
	
	print(inventory)
	
	