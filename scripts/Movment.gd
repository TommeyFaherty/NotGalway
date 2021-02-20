extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 100

var velocity = Vector2()

func _physics_process(delta):
	
	velocity.x = 0
	velocity.y += delta * GRAVITY

	# Animations and movement lumped together 
	# Best to separate them
	if Input.is_action_pressed("space"):
		$AnimatedSprite.play("jump")
	elif Input.is_action_pressed("left_shift") and Input.is_action_pressed(("ui_left")):
		$AnimatedSprite.play("run_left")
		velocity.x = -(WALK_SPEED + 50)
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left_shift") and Input.is_action_pressed(("ui_right")):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run_left")
		velocity.x = WALK_SPEED + 50
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		$AnimatedSprite.play("walk_left")
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  WALK_SPEED
		$AnimatedSprite.play("walk_right")
	else:
		velocity.x = 0
		$AnimatedSprite.play("default")
		$AnimatedSprite.flip_h = false
		
	# jump if space pressed
	if Input.is_action_just_pressed("space"):
		velocity.y = -100
		

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))
