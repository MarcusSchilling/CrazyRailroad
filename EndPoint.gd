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


func _on_Area2D_body_entered(body):
    print("COll")
    if body.get_name() == "Zug":
        var endMenue = load("res://EndMenue.tscn")
        var instance = endMenue.instance()
        instance.setText("Hurray. You won!")
        get_tree().get_root().add_child(instance)
        get_node("/root/main").queue_free()



func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
    print("COll2")
    if body.get_name() == "Zug":
        print("YES")
        var endMenue = load("res://EndMenue.tscn")
        var instance = endMenue.instance()
        instance.setText("Hurray. You won!")
        get_tree().get_root().add_child(instance)
        get_node("/root/main").queue_free()


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
    print("COll3")
    if area.get_name() == "Zug":
        print("YES")
        var endMenue = load("res://EndMenue.tscn")
        var instance = endMenue.instance()
        instance.setText("Hurray. You won!")
        get_tree().get_root().add_child(instance)
        get_node("/root/main").queue_free()


func _on_Area2D_area_entered(area):
    print("COll4")
    if area.get_name() == "Zug":
        print("YES")
        var endMenue = load("res://EndMenue.tscn")
        var instance = endMenue.instance()
        instance.setText("Hurray. You won!")
        get_tree().get_root().add_child(instance)
        get_node("/root/main").queue_free()
