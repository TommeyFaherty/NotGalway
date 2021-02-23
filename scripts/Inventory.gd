extends Node2D


var item = "item_name"
var item_ammount : int
var inventory = {}

func _ready():
	inventory["hp_potion"] = 999
	inventory["chicken_wings"] = 23



func add_item(new_item, item_ammount):
	
	#Check to see if item in inventory
	if inventory[new_item] == true:
		inventory[new_item] = item_ammount
	
	