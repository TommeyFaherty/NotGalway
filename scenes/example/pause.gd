extends Control

func _input(event):
	if event.is_action_pressed(("P_key")):
		print("pausing", not get_tree().paused)
		var new_paused_state = not get_tree().paused
		get_tree().paused = new_paused_state
		visible = new_paused_state