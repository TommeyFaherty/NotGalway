extends Node2D





func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		SaveGame()
	if Input.is_action_just_pressed("ui_cancel"):
		LoadGame()
	
	
	
	
func SaveGame():
	
	#Creating SaveFile
	var game_save = File.new()
	game_save.open("res://TESTSAVE.save", File.WRITE)
	
	#Getting data from nodes that need to be saved
	var save_nodes = get_tree().get_nodes_in_group("SAVE")
	
	#Going through all the nodes that need to be saved
	for node in save_nodes:
		
		#Checking if the node has a save function
		if !node.get_node("Control"):
			#print("'%s' cannot save..." % node.name)
			continue
		
		#Call the nodes save function
		print("Saving '%s' data..." % node.name)
		node.get_node("Control").save()
		#Store the node's save dictionary
		var node_data = node.get_node("Control").save_dict
		print(node_data)

		#Add the save data dictionary into the new save file
		game_save.store_line(to_json(node_data))
		#print("'%s' data_saved" % node.name )
	game_save.close()



func LoadGame():
	
	#Opening the save file
	var game_save = File.new()
	
	#If no save file exists
	if not game_save.file_exists("res://TESTSAVE.save"):
		print("NO SAVE DATA EXISTS")
		return
	
	#Removing existing SAVE nodes from the game
	var load_nodes = get_tree().get_nodes_in_group("SAVE")
	for node in load_nodes:
		node.queue_free()
	
	#Reading the save file 
	game_save.open("res://TESTSAVE.save", File.READ)
	while game_save.get_position() < game_save.get_len():
		
		#Getting the saved dictionary for an in game object from the save file.
		var node_data = parse_json(game_save.get_line())
		
		#Loading the in game object
		var new_object = load(node_data["filename"]).instance()
		
		#Adding the in game object into the game under the correct parent
		get_node(node_data["parent"]).add_child(new_object)
		
		#Placing in game object in last saved position
		new_object.position = Vector2(node_data["pos_x"],node_data["pos_y"])
		
		for data in node_data.keys():
			
			#Skip Position,Filename,Parent of Object
			if data == "filename" or data == "parent" or data == "pos_x" or data == "pos_y":
				continue
			
			#Add Properties to object e.g gold, inventory
			new_object.get_node("Control").set(data, node_data[data])
			print(" '%s' loaded! Here are it's propertiess..." % new_object.name)
			print(node_data)
	
	
	
	
	
	
	
	