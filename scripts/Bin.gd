extends Node2D

var bin_list = ["empty"]

func AddToBin(node_name):
	bin_list.insert(bin_list.size(), node_name)
	
	#print(bin_list)
	#print(bin_list.size())
	
func _ready():
	EmptyBin()

func EmptyBin():
	if bin_list.size() > 1:
		var node_to_bin
		
		print("deleting... " + str(bin_list[1]))
		#print(bin_list[1])
		#print(get_node(str(bin_list[1])))
		get_parent().get_node(bin_list[1]).queue_free()
		#get_parent().get_node("Player").queue_free()
		bin_list.remove(1)
		
		
		#print(bin_list[int(bin_list.size()) - 1])
		#print(bin_list[1])
		
		#INTERVALS AT WHICH OBJECTS ARE DELETED
		var timer = Timer.new()
		add_child(timer)
		timer.start(2)
		timer.autostart = true
		timer.one_shot = true
		timer.connect("timeout",self,"BinEmptied")
	else:
		#INTERVALS AT WHICH OBJECTS ARE DELETED
		print("Bin was empty")
		var timer = Timer.new()
		add_child(timer)
		timer.start(2)
		timer.autostart = true
		timer.one_shot = true
		timer.connect("timeout",self,"BinEmptied")


func BinEmptied():
	EmptyBin()