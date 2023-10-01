extends GridContainer

@export var blank_tile : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = 8
	
	var id = 0;
	for c in get_children():
		c.tile_id = Vector2i(id % columns, floor(id / columns))
		id += 1
	
	# Create the tiles
	#columns = 8
	#for x in columns * columns:
	#	var tile_object = blank_tile.instantiate()
	#	tile_object.tile_id = Vector2i(x % columns, floor(x / columns))
	#	add_child.call_deferred(tile_object)
	
	# Place the units
	#for x in columns:
	#	var pawn_object = test_pawn.instantiate()
	#	get_parent().add_child.call_deferred(pawn_object)
	#	pawn_object = test_pawn.instantiate()
	#	get_parent().add_child.call_deferred(pawn_object)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_unit(unit:Control, pos : Vector2i):
	var idx : int = pos.x + 8 * pos.y
	unit.current_tile = get_child(idx)

func get_tile_pos() -> void:
	pass
