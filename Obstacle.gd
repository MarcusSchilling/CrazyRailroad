extends Node2D

export (PackedScene) var Hitzone
var random
var speed = 100
var start = false
var hit = false
var hitzone
var inArea = false
onready var parent = $Crosshair_rail/PathFollow2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _process(delta):
	if (start && !hit):
		parent.set_offset(parent.get_offset() + speed * delta)
	if (inArea):
		if Input.is_action_just_pressed("ui_select"):
			if !start:
				if(get_node("/root/main/CanvasLayer/GUI").canRepair()):
					get_node("/root/main/CanvasLayer/GUI").repair()
					start = true
					$Sprite_bar.visible = true
					$Sprite_Q.visible = false
					$Crosshair_rail.visible = true
					mini_game()
			else:
				hit = true
				hitzone.get_node("hitzone/CollisionShape2D").disabled = false
				$Timer.start()

func _on_Area2D_area_entered(area):
	if area.get_name() == "Zug":
		print("YES")
		var endMenue = load("res://EndMenue.tscn")
		var instance = endMenue.instance()
		instance.setText("You failed.")
		get_tree().get_root().add_child(instance)
		get_node("/root/main").queue_free()

func _on_Area2D_body_entered(body):
	var inventory = get_node("/root/main/CanvasLayer/GUI")
	if body.get_name() == "player":
		if (inventory.canRepair()):
			get_node("Sprite_Q").visible = true
		else:
			get_node("Sprite_E").visible = true
		inArea = true
	pass


func _on_Area2D_body_exited(body):
	if body.get_name() == "player":
		get_node("Sprite_E").visible = false
		get_node("Sprite_Q").visible = false
		inArea = false
	pass # Replace with function body.pass # Replace with function body.

func mini_game():
		$Sprite_bar/Hitzone_spawn/PathFollow2D.offset = randi()
		hitzone = Hitzone.instance()
		add_child(hitzone)
		hitzone.position = $Sprite_bar/Hitzone_spawn/PathFollow2D.position
		hitzone.position.y -= 100
		hitzone.get_node("hitzone/CollisionShape2D").disabled = true

func _on_Crosshair_area_entered(area):
	print(area.get_name())
	if area.get_name() == "hitzone":
		queue_free()


func _on_Timer_timeout():
	$Sprite_bar.visible = false
	$Sprite_Q.visible = true
	$Crosshair_rail.visible = false
	hitzone.visible = false
	start = false
	parent.set_offset(0)
	hit = false
	hitzone.get_node("hitzone/CollisionShape2D").disabled = true
