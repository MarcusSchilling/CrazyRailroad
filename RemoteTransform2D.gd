extends RemoteTransform2D

var speed = 100
onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + speed * delta)
	pass
	#print(str(global_position.x) + " " + str(global_position.y))
