extends RigidBody2D



func _on_Area2D_body_entered(body):
	
	#Check to see if detecting collisions corecctly - WORKING
	"""if body.collision_layer == 2:
		print("yes")
	else:
		print("no")"""
	#Check to see if body detected is player
	if body.collision_layer ==  2:
		print("Item_collected")
		queue_free()