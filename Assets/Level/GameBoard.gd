extends GridContainer

@export var blank_tile : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = 8
	
	var id = 0;
	for c in get_children():
		c.tile_id = Vector2i(id % columns, floor(id / columns))
		c.change_tile_type(0)
		id += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_unit(unit:Control, pos : Vector2i):
	var idx : int = pos.x + 8 * pos.y
	unit.current_tile = get_child(idx)

func get_tile_type(pos : Vector2i) -> int:
	var idx : int = pos.x + 8 * pos.y
	if pos.x < 0 or pos.y < 0 or pos.x >= columns or idx >= get_child_count():
		return 4
	return get_child(idx).tile_type

func get_tile_pos() -> void:
	pass
