extends Node

var map
var tiless
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum Rail {
	left_right,
	forward,		
	left_forward,
	right_forward,
	back_right,
	back_left,
}
var k_direction = 1
var k = 4
var j = 0
var path
var curve

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	map= get_node("Rails")
	# largura e altura em tiles 
	# ladri = numero de tiles diferentes do tile set
	path = get_node("Path2D")
	curve = path.get_curve()
	curve.clear_points()
	
	print(curve.get_point_count())
	path.set_curve(curve)
	var width =15
	var height = 12
	var n_tiles = 500
	var last_tile = Rail.forward
	for s in range(n_tiles):
		curve = path.get_curve()
		curve.add_point(map.map_to_world(Vector2(k,j)))
		map.set_cell(k,j,last_tile)	  
		createEnvironment(k,j)
		if (s == n_tiles-1):
			createEndBarrier(k,j)	
		if (s % 20 == 0 && s != 0 && s != n_tiles -1):
			createBarrier(k,j)
		if (last_tile == Rail.forward):
			j = j - 1
		elif(last_tile == Rail.left_forward || last_tile == Rail.right_forward):
			j = j - 1
		elif(last_tile == Rail.left_right):
			k = k + k_direction
		elif(last_tile == Rail.back_left ):
			k = k - 1
		elif(last_tile == Rail.back_right):
			k = k + 1
		else:
			print("fail")
		last_tile = nextTile(last_tile)
	pass	
	
	
var k_new
var j_new
 # Replace with function body.
func createBarrier(k,j):
	var scene = load("res://Obstacle.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("end")
	scene_instance.position = map.map_to_world(Vector2(k,j)) + Vector2(0,5)
	add_child(scene_instance)

	for i in range(1):
		var tools = load("res://tools.tscn")
		var tools_scene = tools.instance()
		k_new = k + (20 - randi() % 40)
		j_new = j + (randi() % 10)
		tools_scene.position = map.map_to_world(Vector2(k_new,j_new)) + Vector2(0,5)
		
		add_child(tools_scene)

func createEndBarrier(k,j):
	var scene = load("res://End.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("end")
	scene_instance.position = map.map_to_world(Vector2(k,j))
	add_child(scene_instance)
		

func createEnvironment(k, j):
	for i in range(20):			
		if(map.get_cell(k+i,j) == -1):
			map.set_cell(k + i, j, 6)
		if(map.get_cell(k-i,j) == -1):
			map.set_cell(k - i,j,6)
	map.set_cell(k+20,j,8)
	map.set_cell(k-20,j,8)
var direction
func nextTile(tile):
	match tile:
		Rail.right_forward:
			k_direction = 0
			return _returnRandom([Rail.back_right, Rail.back_left,Rail.forward])
		Rail.left_forward:
			k_direction = 0
			return _returnRandom([Rail.forward, Rail.back_left, Rail.back_right])
		Rail.back_right:
			k_direction = +1
			return _returnRandom([Rail.left_right,Rail.left_forward])
		Rail.back_left:
			k_direction = -1
			return _returnRandom([Rail.right_forward, Rail.left_right])
		Rail.forward:
			k_direction = 0
			return _returnRandom([Rail.back_left,Rail.back_right, Rail.forward])
		Rail.left_right:
			if (k_direction != 0):
				if (k_direction == 1):
					return Rail.left_forward
				else:
					direction = _returnRandom([Rail.left_right,Rail.right_forward]) 
					if (direction == Rail.left_forward):
						k_direction = 0
					return direction
			return _returnRandom([Rail.left_forward, Rail.left_right])

func _returnRandom(tiles):
	var i = tiles[randi() % tiles.size()]
	return i

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
