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
	elif move_direction < 0:
		$Body/AnimatedSprite.flip_h = false
	
#func _physics_process(delta):
#	_handle_move_input()
#	_running_input()
#	_apply_gravity(delta)
##	_apply_movement()
	
#	is_grounded = _check_is_grounded()

#func _input(event):
#	if event.is_action_pressed("space") && is_grounded:
#		velocity.y = JUMP_HEIGHT

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
	if Input.is_action_just_released("E_key"):
		attacking = false

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
	

