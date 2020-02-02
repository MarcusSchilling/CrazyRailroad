extends MarginContainer

const ScrapUI = preload("res://scap_ui.tscn")


var scraps = [];

func _ready():
	pass # Replace with function body.

func addScrap():
	# Using bools for it
	scraps.push_back(true);
	get_node("HBoxContainer").add_child(ScrapUI.instance());
	
func canRepair():
	return howManyLeft() <= 0

func howManyLeft():
	return 1 - scraps.size()

func repair():
	scraps.remove(0)
	var parent = get_node("HBoxContainer")
	var child = parent.get_child(0)
	parent.remove_child(child)
	child.free()
	
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
