extends Control

var slected : bool
@export var piece_type : int
@export var playerSide : int

var selected : bool = false

var wpawn : Node
var wrook : Node
var wbishop : Node
var wknight : Node
var wqueen : Node
var wking : Node
var bpawn : Node
var brook : Node
var bbishop : Node
var bknight : Node
var bqueen : Node
var bking : Node

@export var in_play : bool = true

@export var pos : Vector2i
var current_tile : Control
@export var move_icon: PackedScene

var game_state : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	game_state = get_node("/root/GameState")
	$Button.pressed.connect(select_unit)
	game_state.move_unit(self, pos)
	
	wpawn = $wPawn
	wrook = $wRook
	wbishop = $wBishop
	wknight = $wKnight
	wqueen = $wQueen
	wking = $wKing
	bpawn = $bPawn
	brook = $bRook
	bbishop = $bBishop
	bknight = $bKnight
	bqueen = $bQueen
	bking = $bKing
	
	change_piece_type(piece_type)

func change_piece_type(new_type : int):
	piece_type = new_type
	
	wpawn.visible = false
	bpawn.visible = false
	wrook.visible = false
	brook.visible = false
	wbishop.visible = false
	bbishop.visible = false
	wknight.visible = false
	bknight.visible = false
	wqueen.visible = false
	bqueen.visible = false
	wking.visible = false
	bking.visible = false
	if playerSide == 1:
		if new_type == 0:
			wpawn.visible = true
		if new_type == 1:
			wrook.visible = true
		if new_type == 2:
			wbishop.visible = true
		if new_type == 3:
			wknight.visible = true
		if new_type == 4:
			wqueen.visible = true
		if new_type == 5:
			wking.visible = true
	elif playerSide == 2:
		if new_type == 0:
			bpawn.visible = true
		if new_type == 1:
			brook.visible = true
		if new_type == 2:
			bbishop.visible = true
		if new_type == 3:
			bknight.visible = true
		if new_type == 4:
			bqueen.visible = true
		if new_type == 5:
			bking.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_tile != null:
		global_position = current_tile.global_position
	pass

func select_unit():
	var options : Array[Vector2i] = place_moves()
	# Set up the UI Stuff
	for o in options:
		var new_move = move_icon.instantiate()
		new_move.setup_move(self, o)
		pass

func deselect_unit():
	pass

# Get the places this unit can move.
func place_moves() -> Array[Vector2i]:
	var return_array : Array[Vector2i] = []
	
	var dir : Array[Vector2i] = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
	for d in dir:
		var pos_check : Vector2i = pos
		pos_check += d
		var tiletype : int = game_state.get_tile_type(pos_check)
		if tiletype == 0:
			print_debug(pos_check)
			return_array.append(pos_check)
	return return_array

func take_piece():
	pass
