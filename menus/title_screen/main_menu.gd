extends MarginContainer

const FIRST_SCENE = preload("res://scenes/example/Root.tscn")

# When player is continuing game, Save file must remeber what scene they were on
# From that a variable needs to be created and set with path to that scene

onready var selectors : Array = []
var current_selection = 0
	
func _ready():
	selectors[0] = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/selector
	selectors[1] = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/selector
	selectors[2] = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/selector
	set_current_selection(0)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down") && current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up")  && current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(FIRST_SCENE.instance())
		queue_free()
	elif _current_selection == 1:
# Add options menu here
		print("Add Options")
	elif _current_selection == 2:
		print("Exit")

func set_current_selection(_current_selection):
	for selector in selectors:
		selector = ""
	
	match current_selection:
		0:
			selectors[0].text = ">"
		1:
			selectors[1].text = ">"
		2:
			selectors[2].text = ">"

