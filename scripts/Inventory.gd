extends Node2D


var player_gold = 0
var inventory = {}


func _ready():
	inventory["hp_potion"] = 999
	inventory["chicken_wings"] = 23
	player_gold = 100


func add_item(new_item, received_ammount):
	var existing_ammount 
	
	
	if new_item in inventory:
		existing_ammount = inventory[new_item]
		inventory[new_item] = existing_ammount + received_ammount
	else:
		inventory[new_item] = received_ammount
	
	print(inventory)
	


func GoldUpdate(new_gold):
	var gold_update = new_gold
	#print(str(gold_update) + " gold added")
	player_gold += new_gold
	#print(str(player_gold) + " gold currently in your pockets boi")
