extends Node2D


var player_gold = 0
var inventory = {}
var player_pos = Vector2()

func _ready():
	inventory["hp_potion"] = 999
	inventory["chicken_wings"] = 23
	player_gold = 100

func _physics_process(delta):
	"""TESTING"""
	if Input.is_action_just_pressed("ui_down"):
		SaveGame()
	if Input.is_action_just_pressed("ui_up"):
		LoadGame()
	
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



func SaveGame():
	"""ADDING PROPERTIES TO THE SAVE DICTIONARY"""
	var save_dict = {
		"current_player_inventory" : inventory,
		"current_player_gold" : player_gold,
		"current_player_pos_x" : player_pos.x,
		"current_player_pos_y" : player_pos.y
		}
	print(save_dict)
	
	
	var game_save = File.new()
	game_save.open("res://IFYOUSEETHISTHENGAMEISSAVED.save", File.WRITE)
	game_save.store_line(to_json(save_dict))
	game_save.close()
	print("game saved WOOOOOOOOO!")



func LoadGame():
	var game_save = File.new()
	if not game_save.file_exists("res://IFYOUSEETHISTHENGAMEISSAVED.save"):
		print("NO SAVE DATA EXISTS")
	