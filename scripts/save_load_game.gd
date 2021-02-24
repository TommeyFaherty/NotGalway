extends Node2D

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		SaveGame()
	
	
	
	
func SaveGame():
	#Creating SaveFile
	var game_save = File.new()
	game_save.open("res://IFYOUSEETHISTHENGAMEISSAVED.save", File.WRITE)
	var save_nodes
	
	
	
	game_save.store_line(to_json(save_dict))
	game_save.close()
	print("game saved WOOOOOOOOO!")



func LoadGame():
	#READING THE SAVE FILE
	var game_save = File.new()
	if not game_save.file_exists("res://IFYOUSEETHISTHENGAMEISSAVED.save"):
		print("NO SAVE DATA EXISTS")
	game_save.open("res://IFYOUSEETHISTHENGAMEISSAVED.save", File.READ)
	while game_save.get_position() < game_save.get_len():
		var node_data = parse_json(game_save.get_len())
		"""
		var new_object = load(node_data["filename"]).instance()
		get_node(node_data["parent"]).add_child(new_object)
		#LOAD OBJECT POSITION
		#new_object.position = Vector2(node_data["pos_x"],node_data["pos_y"])
		"""
		
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set("
	
	
	
	
	
	
	
	