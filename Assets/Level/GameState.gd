extends Node

var board : Node
var tiles : Array[int]
var units : Array[Node]

var selected : Node

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

func move_unit(unit: Node, new_pos : Vector2i):
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
	
	# Update the graphic
	if get_node("/root/TestLevel") != null:
		get_node("/root/TestLevel/BoardTiles").position_unit(unit, new_pos)
	

func restart():
	pass
