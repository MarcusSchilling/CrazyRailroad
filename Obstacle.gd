extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

var inArea = false
func _on_Area2D_body_entered(body):
    var inventory = get_node("/root/main/CanvasLayer/GUI")
    if body.get_name() == "Zug":
        var endMenue = load("res://EndMenue.tscn")
        var instance = endMenue.instance()
        instance.setText("You failed.")
        get_tree().get_root().add_child(instance)
        get_node("/root/main").queue_free()
    if body.get_name() == "player":
        if (inventory.canRepair()):
            get_node("Sprite_?").visible = true
        else:
            get_node("Sprite_!").visible = true
        inArea = true
    pass # Replace with function body.


func _on_Area2D_body_exited(body):
    if body.get_name() == "player":
        get_node("Sprite_!").visible = false
        get_node("Sprite_?").visible = false
        inArea = false
    pass # Replace with function body.

func _input(ev):
    var inventory = get_node("/root/main/CanvasLayer/GUI")
    if ev is InputEventKey and ev.scancode == KEY_K:
        if(inArea && inventory.canRepair()):
            inventory.repair()
            queue_free()
            get_node("Sprite_!").visible = true
            get_node("Sprite_?").visible = false
			
		#code
