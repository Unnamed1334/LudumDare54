extends Node

var board : Node
var tiles : Array[int]
var units : Array[Node]

var selected : Node


var ui_objects : Array[Node]

var player_turn = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	tiles.resize(64)
	units.resize(64)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func click_tile(pos:Vector2i):
	print_debug(pos)
	
	var unit = get_unit(pos)
	if selected == null:
		if unit != null:
			print_debug("Found something")
			selected = unit
	else:
		if unit == selected:
			selected = null

func get_unit(pos : Vector2i):
	var idx : int = pos.x + 8 * pos.y
	return units[idx]
	
func get_unit_type(pos : Vector2i):
	var idx : int = pos.x + 8 * pos.y
	if pos.x < 0 or pos.y < 0 or pos.x >= 8 or idx >= 64:
		return -2
	if units[idx]:
		return units[idx].piece_type
	else:
		return -1

func move_unit(unit: Node, new_pos : Vector2i, affected_tiles : Array[Vector2i], terraforming_mode : int):
	if units.size() != 64:
		units.resize(64)
	
	var old_idx : int = units.find(unit)
	# Remove from old
	if old_idx != -1:
		units[old_idx] = null
	
	var new_idx : int = new_pos.x + 8 * new_pos.y
	# Take units it lands on
	if units[new_idx] != null:
		print_debug("Captured a piece")
		units[new_idx].take_piece()
	
	# Place unit
	units[new_idx] = unit
	unit.pos = new_pos
	
	# Handle terraforming
	for tile in affected_tiles:
		tiles[tile.x+8 * tile.y] = terraforming_mode
	
	# capture in pits
	if get_tile_type(unit.pos) == 2:
		unit.take_piece()
	
	# Update the graphic
	if get_node("/root/TestLevel") != null:
		get_node("/root/TestLevel/BoardTiles").position_unit(unit, new_pos)
	
	if player_turn == 1:
		player_turn = 2
	else:
		player_turn = 1
	
	# Clear the current UI
	clear_ui()

# Position unit without updating turn
func place_unit(unit: Node, new_pos : Vector2i):
	if units.size() != 64:
		units.resize(64)
	var new_idx : int = new_pos.x + 8 * new_pos.y
	# Place unit
	units[new_idx] = unit
	unit.pos = new_pos
	# Update the graphic
	if get_node("/root/TestLevel") != null:
		get_node("/root/TestLevel/BoardTiles").position_unit(unit, new_pos)

func get_tile_type(pos : Vector2i) -> int:
	var idx : int = pos.x + 8 * pos.y
	if pos.x < 0 or pos.y < 0 or pos.x >= 8 or pos.y >= 8:
		return 4
	return tiles[idx]

func add_ui(element: Node):
	ui_objects.append(element)
	pass

func clear_ui():
	for o in ui_objects:
		o.queue_free()
	ui_objects = []

func get_tile(pos : Vector2i):
	var idx : int = pos.x + 8 * pos.y
	if get_node("/root/TestLevel") != null:
		return get_node("/root/TestLevel/BoardTiles").get_child(idx)
	return null


func get_tile_team(pos : Vector2i) -> int:
	# 0 - empty, 1 - white, 2 - black
	var idx : int = pos.x + 8 * pos.y
	if pos.x < 0 or pos.y < 0 or pos.x >= 8 or idx >= 64:
		return 0
	if units[idx] != null:
		return units[idx].playerSide
	return 0

func restart():
	pass
