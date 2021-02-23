extends KinematicBody2D

onready var hp_bar = $TextureProgress
onready var damage_bar = $TextureProgress2

var max_hp : float = 10
var current_hp : float = 7
var old_hp : float = 7

func _ready():
	current_hp = 10
	old_hp = current_hp

func _physics_process(delta):
	Hp()

func UpdateHp(new_hp):
	old_hp = current_hp
	current_hp += new_hp
	print(current_hp)
	#When "new_hp" is negative (taking damage)
	if new_hp < 0:
		Hurt()
	#When hp reaches 0
	if current_hp <= 0:
		Dead()






func Hurt():
	#Hurt animation AND character invulnerability while in hitstun
	$AnimationPlayer.play("hurt")


func Dead():
	$AnimationPlayer.play("die")
	yield(get_tree().create_timer(3.0), "timeout")
	queue_free()




func Hp():
	#Doesn't let Hp go below 0
	if current_hp < 0:
		current_hp = 0
	
	#Doesn't let Hp go higher than max hp
	if current_hp > max_hp:
		current_hp = max_hp
	#GREEN HP BAR
	hp_bar.value = (current_hp / max_hp) * 100
	print( (current_hp / max_hp) * 100)
	#RED DAMAGE BAR
	damage_bar.value = (old_hp / max_hp) * 100
	#RED DAMAGE BAR DELAY
	if old_hp > current_hp:
		old_hp -= 0.05
		yield(get_tree().create_timer(0.5), "timeout")
		return
