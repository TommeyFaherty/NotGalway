extends "res://globals/state_machine.gd"

func _ready():
	add_state('idle')
	add_state('run')
	add_state('walk')
	add_state('fall')
	add_state('jump')
	add_state('attack')
	call_deferred("set_state", states.idle)

func _input(event):
	if [states.idle, states.walk, states.run].has(state):
		# Jump
		if event.is_action_pressed("space") && parent.is_on_floor():
			parent.velocity.y = parent.JUMP_HEIGHT
			#is_jumping = true
	
	if state == states.jump:	
		if event.is_action_released("space") && parent.velocity.y < 0:
			parent.velocity.y = 0
			

func _state_logic(delta):
	parent._handle_move_input()
	parent._running_input()
	parent._apply_gravity(delta)
	parent._apply_movement()
	
func _get_transition(delta):
	match state:
		states.idle:
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.attacking == true:
				return states.attack
			elif parent.velocity.x != 0 && parent.is_running == false:
				return states.walk
			elif parent.velocity.x != 0 && parent.is_running == true:
				return states.run
		states.walk:
			if parent.attacking == true:
				return states.attack
			elif !parent.is_on_floor():
				if parent.velocity.y < 0:	
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0 && parent.is_running == true:
				return states.run
			elif parent.velocity.x == 0:
				return states.idle
		states.run:
			if parent.attacking == true:
				return states.attack
			elif !parent.is_on_floor():
				if parent.velocity.y < 0:	
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x != 0 && parent.is_running == false:
				return states.walk
			elif parent.velocity.x == 0:
				return states.idle
		states.jump:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
		states.attack:
			if parent.attacking == false:
				if parent.is_on_floor():
					return states.idle
				elif parent.velocity.y >= 0:
					return states.fall
				
	return null
		
func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.anim_player.play("idle")
		states.walk:
			parent.anim_player.play("Run")
			#parent.anim_player.play("walk_left")
		states.run:
			parent.anim_player.play("Run")
		states.jump:
			print("jump")
			#parent.anim_player.play("jump")
		states.fall:
			print("fall")
			#parent.anim_player.play("jump")
		states.attack:
			print("attack")
			#parent.anim_player.play("attack")
	
func _exit_state(old_state, new_state):
	pass
