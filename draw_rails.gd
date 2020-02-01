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
var k_direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	map= get_node("Rails")
	# largura e altura em tiles 
	# ladri = numero de tiles diferentes do tile set
	
	var width =15
	var height = 12
	var n_tiles = 6 
	var last_tile = Rail.forward
	var k = 4
	var j = 0
	for s in range(height):
		last_tile = nextTile(last_tile)
		print(last_tile)
		print(k_direction)
		map.set_cell(k,j,last_tile)	  
		if (last_tile == 3):
			j = j - 1			
		elif(last_tile == 2 || last_tile == 4):
			j = j - 1
		elif(last_tile == 3):
			k = k + k_direction
		else:
			k = k + k_direction
	pass	
 # Replace with function body.

func nextTile(tile):
	match tile:
		Rail.right_forward:
			return _returnRandom([Rail.back_right, Rail.back_left,Rail.forward])
		Rail.left_forward:
			return _returnRandom([Rail.back_right, Rail.back_left])
		Rail.back_right:
			k_direction = +1
			return _returnRandom([Rail.left_right,Rail.left_forward])
		Rail.back_left:
			k_direction = -1
			return _returnRandom([Rail.right_forward, Rail.left_right])
		Rail.forward:
			return _returnRandom([Rail.back_left,Rail.back_right])
		Rail.left_right:
			return _returnRandom([Rail.left_forward, Rail.left_right])

func _returnRandom(tiles):
	print(tiles)
	var i = tiles[randi() % tiles.size()]
	print(Rail.keys()[i])
	return i

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
