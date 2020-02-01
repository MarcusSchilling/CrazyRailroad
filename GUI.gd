extends MarginContainer

const ScrapUI = preload("res://scap_ui.tscn")


var scraps = [];

func _ready():
	pass # Replace with function body.

func addScrap():
	# Using bools for it
	scraps.push_back(true);
	get_node("HBoxContainer").add_child(ScrapUI.instance());
	

func howManyLeft():
    return 5 - scraps.size()

func repair():
    scraps.clear()