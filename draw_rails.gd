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

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	map= get_node("Rails")
	# largura e altura em tiles 
	# ladri = numero de tiles diferentes do tile set
	
	var width =15
	var height = 12
	var n_tiles = 1000
	var last_tile = Rail.forward
	map.set_cell(5,5,Rail.right_forward)
	for s in range(n_tiles):
		print(Rail.keys()[last_tile])
		map.set_cell(k,j,last_tile)	  
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
 # Replace with function body.

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
					return Rail.left_right
			return _returnRandom([Rail.left_forward, Rail.left_right])

func _returnRandom(tiles):
	var i = tiles[randi() % tiles.size()]
	return i

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
