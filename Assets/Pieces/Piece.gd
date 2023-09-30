extends Control

var slected : bool
var type : String	#possible values: "Pawn","Rook","Bishop","Knight","Queen","King","Wall","Pit","Ice"
var playerSide : int#1 -> white, -1 -> black, 0 -> neutral/terrain

var pos : Vector2i

@export var move_icon: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# change active sprite based on piece value
	if type not in ["Pawn","Rook","Bishop","Knight","Queen","King"]:
		playerSide = 0
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


# Get the places this unit can move.
func place_moves() -> Array[Node]:
	var array : Array[Node] = []
	return array
