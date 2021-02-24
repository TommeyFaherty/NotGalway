extends Node2D





func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		SaveGame()
	if Input.is_action_just_pressed("ui_cancel"):
		LoadGame()
	
	
	
	
func SaveGame():
	
	#Creating SaveFile
	var game_save = File.new()
	game_save.open("res://IFYOUSEETHISTHENGAMEISSAVED.save", File.WRITE)
	
	#Getting data from nodes that need to be saved
	var save_nodes = get_tree().get_nodes_in_group("SAVE")
	
	#Going through all the nodes that need to be saved
	for node in save_nodes:
		
		#Checking if the node has a save function
		if !node.get_node("Control"):
			print("'%s' cannot save..." % node.name)
			continue
		
		#Call the nodes save function
		print("Saving '%s' data..." % node.name)
		var node_data = node.get_node("Control").save()

		#Add the save data dictionary into the new save file
		game_save.store_line(to_json(node_data))
		print("'%s' data_saved" % node.name )
	game_save.close()



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
		
		"""for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set"""
	
	
	
	
	
	
	
	