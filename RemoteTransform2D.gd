extends RemoteTransform2D

var speed = 100
var old = Vector2(0,0)
var motion = Vector2(0,0)
onready var parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
	pass
	#print(str(global_position.x) + " " + str(global_position.y))
	motion = Vector2(global_position.x - old.x, global_position.y - old.y)
	old = Vector2(global_position.x, global_position.y)
	print(str(motion.x) + " " + str(motion.y))
	get_node("/root/main/YSort/Floor/Zug").animation(motion)
	
	
