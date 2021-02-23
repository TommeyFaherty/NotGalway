extends RigidBody2D



#Bronze, Silver, Gold CAN ADD OTHER TYPES LATER
var coin_type = "golden"
var coin_value = 0
var rng = RandomNumberGenerator.new()
#
var dead = false


func _ready():
	self.bounce = 100
	$AnimationPlayer.play("Spinning")

func _physics_process(delta):
	#RNG
	rng.randomize()
	
	#Golden Coin
	if coin_type == "golden":
		coin_value = randi() % 30 + 90
	
	

func _on_Area2D_body_entered(body):
	if body.collision_layer ==  2:
		if dead == false:
			body.get_node("Inventory").GoldUpdate(coin_value)
			#EXIT GAME
			self.visible = false
			$CollisionShape2D.disabled = true
			$Area2D.monitoring = false
			dead = true
			get_parent().get_node("Bin").AddToBin(self.name)