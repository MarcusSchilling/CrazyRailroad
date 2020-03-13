extends Node

var map
var start_environment_map
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
var places_for_items = {}
#minimum 13 because otherwise the field is not fully surrounded by a fence
var one_direction_distance = 13

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	map= get_node("Rails")
	start_environment_map = get_node("start_envirement")
	# largura e altura em tiles 
	# ladri = numero de tiles diferentes do tile set
	path = get_node("Path2D")
	curve = path.get_curve()
	curve.clear_points()
	
	print(curve.get_point_count())
	path.set_curve(curve)
	var width =15
	var height = 12
	var n_tiles = 512
	var last_tile = Rail.forward
	var number_of_barriers = 0
	for s in range(n_tiles):
		curve = path.get_curve()
		curve.add_point(map.map_to_world(Vector2(k,j)))
		map.set_cell(k,j,last_tile)	  
		if (s == n_tiles-1):
			createEndBarrier(k,j)
		if (s % 20 == 0 && s != 0 && s != n_tiles -1):
			createBarrier(k,j)
			number_of_barriers = number_of_barriers + 1	
		if (last_tile == Rail.forward):
			createEnvironment(Vector2(k,j), +1)
			createEnvironment(Vector2(k,j), -1)
			j = j - 1
		elif(last_tile == Rail.left_forward || last_tile == Rail.right_forward):
			if(last_tile == Rail.left_forward):
				createEnvironment(Vector2(k,j), +1)
			else:
				createEnvironment(Vector2(k,j), -1)
			j = j - 1
		elif(last_tile == Rail.left_right):
			k = k + k_direction
		elif(last_tile == Rail.back_left ):
			createEnvironment(Vector2(k,j), +1)
			k = k - 1
		elif(last_tile == Rail.back_right):
			createEnvironment(Vector2(k,j), -1)
			k = k + 1
		else:
			print("fail")
		last_tile = nextTile(last_tile)
	pass	
	createItems(number_of_barriers + 5)

var j_old = 0
 # Replace with function body.
func createBarrier(k,j):
	var scene = load("res://Obstacle.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("end")
	scene_instance.position = map.map_to_world(Vector2(k,j)) + Vector2(0,5)
	add_child(scene_instance)
	
func createItems(number_of_items):
	for i in range(0, number_of_items):
		var tools = load("res://tools.tscn")
		var tools_scene = tools.instance()
		j_old = 0
		var j_new  = places_for_items.keys()[randi() % places_for_items.size()]
		var range_places = range(places_for_items.get(j_new).x, places_for_items.get(j_new).y)
		var k_new = range_places[randi() % range_places.size()]
		tools_scene.position = map.map_to_world(Vector2(k_new,j_new)) + Vector2(0,5)
		if (map.get_cell(k_new,j_new) == -1):
			print("Fail no underground")
			print("K:", k_new, " J:", j_new)
		add_child(tools_scene)

func createEndBarrier(k,j):
	var scene = load("res://End.tscn")
	var scene_instance = scene.instance()
	scene_instance.set_name("end")
	scene_instance.position = map.map_to_world(Vector2(k,j))
	add_child(scene_instance)
	createEnvironment(Vector2(k,j), -1)
	createEnvironment(Vector2(k,j), +1)
	for i in range(0,one_direction_distance):
		map.set_cell(k+i,j-1,8)
		map.set_cell(k-i,j-1,8)		

func createEnvironment(k, j):
	var start;
	var end;
	for i in range(one_direction_distance):
		if(map.get_cell(k.x+(j*i),k.y) == -1):
			if start == null:
				start = k.x + (j*i)
			else:
				end = k.x + (j*i)
			map.set_cell(k.x + (j*i), k.y, 6)
			if (map.get_cell(k.x+(j*i),k.y +1) == -1 && start_environment_map.get_cell(k.x+(j*i),k.y+1) == -1):
				map.set_cell(k.x+(j*i), k.y + 1,8)
		#builds border for the last row that is close to this if the current grass exceeds the last
		if(map.get_cell(k.x+(j*i),k.y+1) == -1 && k.y != 0):
			start_environment_map.set_cell(k.x+(j*i),k.y+1,8)
	
	#places for items
	if start ==null:
		start = k.x
	if end == null:
		end = k.x
	var vec = Vector2(min(start,end), max(start,end))
	var a = places_for_items.get(k.y, Vector2(start,end))
	places_for_items[k.y] = Vector2(min(a.x,vec.x),max(a.y,vec.y))
	
	#border
	map.set_cell(k.x+ (j*one_direction_distance),k.y,8)
	if(map.get_cell(k.x+ (j*one_direction_distance),k.y+1) == -1):
		map.set_cell(k.x + (j*one_direction_distance),k.y +1, 8)
	var i = 0
	while(map.get_cell(k.x+(j*(one_direction_distance+i)),k.y+1) != 8):
		map.set_cell(k.x+(j*(one_direction_distance+i)),k.y, 8)
		i=i+1
	i = 1
	while(map.get_cell(k.x+i,k.y) == Rail.left_right && map.get_cell(k.x+i,k.y+1) == -1):
		map.set_cell(k.x+i,k.y+1, 8)
		i = i+1
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
