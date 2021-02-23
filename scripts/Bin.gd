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
		get_parent().get_node(str(bin_list[1])).queue_free()
		#print(get_node(bin_list[1]))
		bin_list.remove(1)
		
		#INTERVAL TIME
		var timer = Timer.new()
		add_child(timer)
		timer.start(0.5)
		timer.autostart = true
		timer.one_shot = true
		timer.connect("timeout",self,"BinEmptied")
	else:
		#INTERVAL TIME
		#print("Bin was empty")
		var timer = Timer.new()
		add_child(timer)
		timer.start(0.5)
		timer.autostart = true
		timer.one_shot = true
		timer.connect("timeout",self,"BinEmptied")


func BinEmptied():
	EmptyBin()