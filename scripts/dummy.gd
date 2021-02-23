extends KinematicBody2D

onready var hp_bar = $TextureProgress


var max_hp : float = 10
var current_hp : float = 0

func _ready():
	current_hp = 7
	

func _physics_process(delta):
	Hp()

func UpdateHp(new_hp):
	current_hp += new_hp
	print(current_hp)

func Hp():
	#Doesn't let Hp go below 0
	if current_hp < 0:
		current_hp = 0
	
	#Doesn't let Hp go higher than max hp
	if current_hp > max_hp:
		current_hp = max_hp
	
	hp_bar.value = (current_hp / max_hp) * 100
	print( (current_hp / max_hp) * 100)
	
	