extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main = preload("res://main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func setText(text):
	get_node("CenterContainer/VBoxContainer/CenterContainer2/Text").set_text(text)
	pass

func _on_TextureButton_pressed():
	get_tree().get_root().add_child(main.instance())
	get_node("/root/EndMenue").queue_free()


