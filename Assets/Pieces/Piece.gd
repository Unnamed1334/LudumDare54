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
	game_state.clear_ui()
	
	var options : Array[Vector2i] = place_moves()
	# Set up the UI Stuff
	for o in options:
		var new_move = move_icon.instantiate()
		add_child(new_move)
		new_move.setup_move(self, o)
		game_state.add_ui(new_move)
		new_move.target_tile = game_state.get_tile(o)

func deselect_unit():
	game_state.clear_ui()
	pass

# Get the places this unit can move.
func place_moves() -> Array[Vector2i]:
	var return_array : Array[Vector2i] = []
	
	if piece_type == 0: # pawn
		var dir : Vector2i = Vector2i(0,-1)
		if playerSide == 2:
			dir = Vector2i(0,1)
		
		# check normal movement
		var pos_check : Vector2i = pos + dir
		var tiletype : int = game_state.get_tile_type(pos_check)
		if tiletype == 0: # should instead check if not occupied
			return_array.append(pos_check)
		#check Double Step move
		if (pos.y == 6 && playerSide == 1) || (pos.y == 1 && playerSide == 2):
			pos_check = pos + dir + dir
			tiletype = game_state.get_tile_type(pos_check)
			if tiletype == 0:
				return_array.append(pos_check)
		#check capturing
		pos_check = pos + dir + Vector2i(1,0)
		var captureCheck : int = game_state.get_unit_side(pos_check)
		tiletype = game_state.get_tile_type(pos_check)
		if captureCheck != playerSide && captureCheck != 0 && tiletype == 0:
			return_array.append(pos_check)
		pos_check = pos + dir + Vector2i(-1,0)
		captureCheck = game_state.get_unit_side(pos_check)
		tiletype = game_state.get_tile_type(pos_check)
		if captureCheck != playerSide && captureCheck != 0 && tiletype == 0:
			return_array.append(pos_check)
		
	if piece_type == 3: # knight
		var signs = [Vector2i(1,1),Vector2i(-1,1),Vector2i(1,-1),Vector2i(-1,-1)]
		var moves = [[Vector2i(1,0),Vector2i(1,0),Vector2i(0,1)],[Vector2i(0,1),Vector2i(1,0),Vector2i(1,0)],
			[Vector2i(0,1),Vector2i(0,1),Vector2i(1,0)],[Vector2i(1,0),Vector2i(0,1),Vector2i(0,1)]]
		
		for s in signs:
			for path in moves:
				var valid = true;
				var pos_check : Vector2i = pos
				for move in path:
					var next_step = move # Shift move sign to get other cases
					next_step.x *= s.x
					next_step.y *= s.y
					pos_check += next_step # Do each step
					# Valid check
					var tiletype : int = game_state.get_tile_type(pos_check)
					if tiletype != 0:
						valid = false
				if valid:
					return_array.append(pos_check)
	if piece_type == 1: # rook
		var dir : Array[Vector2i] = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1)]
		for d in dir:
			var pos_check : Vector2i = pos
			for i in 8:
				pos_check += d
				var tiletype : int = game_state.get_tile_type(pos_check)
				if tiletype == 0:
					return_array.append(pos_check)
	if piece_type == 2: # bishop
		var dir : Array[Vector2i] = [Vector2i(1,1),Vector2i(-1,1),Vector2i(1,-1),Vector2i(-1,-1)]
		for d in dir:
			var pos_check : Vector2i = pos
			for i in 8:
				pos_check += d
				var tiletype : int = game_state.get_tile_type(pos_check)
				if tiletype == 0:
					return_array.append(pos_check)
	if piece_type == 4: # queen
		var dir : Array[Vector2i] = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1),
			Vector2i(1,1),Vector2i(-1,1),Vector2i(1,-1),Vector2i(-1,-1)]
		for d in dir:
			var pos_check : Vector2i = pos
			for i in 8:
				pos_check += d
				var tiletype : int = game_state.get_tile_type(pos_check)
				if tiletype == 0:
					return_array.append(pos_check)
	if piece_type == 5: # king
		var dir : Array[Vector2i] = [Vector2i(1,0),Vector2i(-1,0),Vector2i(0,1),Vector2i(0,-1),
			Vector2i(1,1),Vector2i(-1,1),Vector2i(1,-1),Vector2i(-1,-1)]
		for d in dir:
			var pos_check : Vector2i = pos
			pos_check += d
			var tiletype : int = game_state.get_tile_type(pos_check)
			if tiletype == 0:
				return_array.append(pos_check)
	
	return return_array

func take_piece():
	pass
