extends KinematicBody2D

var ITEM = preload("res://scenes/Item.tscn")
var no_of_drops = 1

var COIN = preload("res://scenes/Coin.tscn")
var no_of_coins = 10


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
	#print(current_hp)
	#When "new_hp" is negative (taking damage)
	if new_hp < 0:
		if current_hp <= 0:
			pass
		else:
			Hurt()
	#When hp reaches 0
	

func Hurt():
	#Hurt animation AND character invulnerability while in hitstun
	$AnimationPlayer.play("hurt")


func Dead():
	#Play animation
	$AnimationPlayer.play("die")
	
	#Drop Items
	if no_of_drops > 0:
		var loot_drop = ITEM.instance()
		get_parent().add_child(loot_drop)
		loot_drop.position = self.position + Vector2(0,-20)
		no_of_drops -= 1
	
	#Drop Coins
	var gold_drop = COIN.instance()

	if no_of_coins > 0:
		get_parent().add_child(gold_drop)
		gold_drop.position = self.position + Vector2(0,-10)
		no_of_coins -= 1
		print(no_of_coins)
		yield(get_tree().create_timer(0.5), "timeout")
		return
		
	
	#Remove the dummy from the game
	yield(get_tree().create_timer(3.0), "timeout")
	queue_free()




func Hp():
	#Doesn't let Hp go below 0
	if current_hp <= 0:
		current_hp = 0
		Dead()
	
	#Doesn't let Hp go higher than max hp
	if current_hp > max_hp:
		current_hp = max_hp
	#GREEN HP BAR
	hp_bar.value = (current_hp / max_hp) * 100
	#print( (current_hp / max_hp) * 100)
	#print(current_hp)
	#RED DAMAGE BAR
	damage_bar.value = (old_hp / max_hp) * 100
	#RED DAMAGE BAR DELAY
	if old_hp > current_hp:
		old_hp -= 0.05
		#yield(get_tree().create_timer(0.5), "timeout")
		return
