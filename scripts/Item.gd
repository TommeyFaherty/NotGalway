extends RigidBody2D

var item_name = "dummy_corpse"
var item_ammount = 1




func _on_Area2D_body_entered(body):
	
	#Check to see if detecting collisions corecctly - WORKING
	"""if body.collision_layer == 2:
		print("yes")
	else:
		print("no")"""
	#Check to see if body detected is player
	if body.collision_layer ==  2:
		body.get_node("Inventory").add_item(item_name,item_ammount)
		queue_free()