extends Control

#const FIRST_SCENE = preload("res://scenes/example/Root.tscn")
#const SETTINGS_SCENE = preload("res://menus/title_screen/SettingsMenu.tscn")

# When player is continuing game, Save file must remeber what scene they were on
# From that a variable needs to be created and set with path to that scene

onready var selectors = [
	$MarginContainer/CenterContainer/VBoxContainer/OptionsContainer/VBoxContainer/ContinueContainer/HBoxContainer/selector,
	$MarginContainer/CenterContainer/VBoxContainer/OptionsContainer/VBoxContainer/SaveContainer/HBoxContainer/selector,
	$MarginContainer/CenterContainer/VBoxContainer/OptionsContainer/VBoxContainer/ExitContainer/HBoxContainer/selector
]
var current_selection = 0
	
func _ready():
	set_current_selection(0)
	print('ready')
	
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
		#get_parent().add_child(FIRST_SCENE.instance())
		print("Should unfreeze game and close pause menu")
		queue_free()
	elif _current_selection == 1:
		print("Should open save menu to select a save file")
	elif _current_selection == 2:
		print("Exit")

func set_current_selection(_current_selection):
	for selector in selectors:
		selector.text = ""
	
	match current_selection:
		0:
			selectors[0].text = ">"
		1:
			selectors[1].text = ">"
		2:
			selectors[2].text = ">"

