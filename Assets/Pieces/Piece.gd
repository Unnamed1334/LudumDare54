extends Control

var slected : bool
var type : String	#possible values: "Pawn","Rook","Bishop","Knight","Queen","King","Wall","Pit","Ice"
var playerSide : int#1 -> white, -1 -> black, 0 -> neutral/terrain

var selected : bool = false

@export var in_play : bool = true

@export var pos : Vector2i
@export var move_icon: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# change active sprite based on piece value
	if type not in ["Pawn","Rook","Bishop","Knight","Queen","King"]:
		playerSide = 0
	$Button.pressed.connect(place_moves)
	get_node("/root/GameState").move_unit(self, pos)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# update piece graphics. probably should be called only when created, but it's fine.
	if type in ["Pawn","Rook","Bishop","Knight","Queen","King"]:
		var path = "res://Assets/Pieces/Chess"
		if playerSide < 0:
			path += "B"
		path += type
		path += ".png"
		$Sprite.texture = load(path)
	else:
		var path = "res://Assets/tiles/Chess"
		path += type
		path += " Tile.png"
		$Sprite.texture = load(path)
	pass

func select_unit():
	place_moves()
	pass

# Get the places this unit can move.
func place_moves() -> Array[Node]:
	print_debug("123")
	
	var array : Array[Node] = []
	return array

func take_piece():
	pass
