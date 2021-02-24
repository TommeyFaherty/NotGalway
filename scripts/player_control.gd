extends Node2D


var player_gold = 0
var inventory = {}
var player_pos = Vector2()

func _ready():
	inventory["hp_potion"] = 999
	inventory["chicken_wings"] = 23
	player_gold = 100
	

func _physics_process(delta):
	player_pos.x = get_parent().position.x
	player_pos.y = get_parent().position.y



func add_item(new_item, received_ammount):
	var existing_ammount 
	
	
	if new_item in inventory:
		existing_ammount = inventory[new_item]
		inventory[new_item] = existing_ammount + received_ammount
	else:
		inventory[new_item] = received_ammount
	
	#print(inventory)
	


func GoldUpdate(new_gold):
	var gold_update = new_gold
	#print(str(gold_update) + " gold added")
	player_gold += new_gold
	#print(str(player_gold) + " gold currently in your pockets boi")



func save():
	"""ADDING PROPERTIES TO THE SAVE DICTIONARY"""
	var save_dict = {
		"parent" : get_parent().get_parent().get_path(),
		"filename"  : get_parent().get_filename(), 
		"player_inventory" : inventory,
		"player_gold" : player_gold,
		"player_pos_x" : player_pos.x,
		"player_pos_y" : player_pos.y
	}
	print(save_dict)
	#return save()
	