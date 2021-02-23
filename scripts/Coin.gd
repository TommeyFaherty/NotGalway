extends RigidBody2D



#Bronze, Silver, Gold CAN ADD OTHER TYPES LATER
var coin_type = "gold"
var coin_value = 0

func _ready():
	self.bounce = 100


func _physics_process(delta):
	


func _on_Area2D_body_entered(body):
	if body.collision_layer ==  2:
		body.get_node("Inventory").add_item(gold_ammount)
		queue_free()