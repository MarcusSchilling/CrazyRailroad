extends Area2D

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"s

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	get_node("/root/main/GUI").addScrap()
	get_parent().queue_free()
	
