extends KinematicBody2D

var max_hp = 10
var current_hp = 0

func _ready():
	current_hp = max_hp
	



func UpdateHp(new_hp):
	current_hp += new_hp
	print(current_hp)
	if current_hp < 0:
		current_hp = 0

