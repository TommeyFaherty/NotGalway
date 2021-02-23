extends RigidBody2D

var item_name = "dummy_corpse"
var item_ammount = 3
var dead = false



func _on_Area2D_body_entered(body):
	
	#Check to see if body detected is player
	if body.collision_layer ==  2:
		if dead == false:
			#KILLING the node
			self.visible = false
			$CollisionShape2D.disabled = true
			$Area2D.monitoring = false
			dead = true
			#Adding Item
			body.get_node("Inventory").add_item(item_name,item_ammount)
			