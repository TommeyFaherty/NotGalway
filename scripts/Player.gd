extends KinematicBody2D

const SLOPE_STOP = 64
const GRAVITY = 200.0
const WALK_SPEED = 100
const JUMP_HEIGHT = -100 
const UP =Vector2(0, -1)

var velocity = Vector2()
onready var raycasts = $Raycasts
onready var anim_player = $Body/AnimatedSprite
var is_grounded
var is_running
var move_direction
var attacking
	
func _handle_move_input():
	move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	velocity.x = lerp(velocity.x, WALK_SPEED * move_direction, 0.2)
	if move_direction > 0:
		$Body/AnimatedSprite.flip_h = true
		$Body/Area2D.rotation_degrees = 0
	elif move_direction < 0:
		$Body/AnimatedSprite.flip_h = false
		$Body/Area2D.rotation_degrees = 180

func _running_input():
	# Animations and movement lumped together 
	# Best to separate them
	if Input.is_action_pressed("left_shift") and Input.is_action_pressed(("ui_left")):
		velocity.x = -(WALK_SPEED + 50)
		is_running = true
	elif Input.is_action_pressed("left_shift") and Input.is_action_pressed(("ui_right")):
		velocity.x = WALK_SPEED + 50
		is_running = true
	else:
		is_running = false
	
	if Input.is_action_pressed("E_key"):
		attacking = true
		$Body/Area2D.monitoring = true
	if Input.is_action_just_released("E_key"):
		attacking = false
		$Body/Area2D.monitoring = false

func _apply_gravity(delta):
	velocity.y += delta * GRAVITY

func _apply_movement():
	velocity = move_and_slide(velocity, UP, SLOPE_STOP)
	#velocity = move_and_slide(velocity)
	#print(is_on_floor())
	
func _check_is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
			
	return false
	



func _on_Area2D_body_entered(body):
	body.UpdateHp(-1)
	
