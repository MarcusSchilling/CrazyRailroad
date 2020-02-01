extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ScrapUI = preload("res://scap_ui.tscn")


var scraps = [];

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func addScap():
    # Using bools for it
    scraps.push_back(true);
    get_node("HBoxContainer").add_child(ScrapUI.instance());
    
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
