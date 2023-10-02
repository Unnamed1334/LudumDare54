extends GridContainer

@export var blank_tile : PackedScene

@export var pawn_ui : Node
@export var rook_ui : Node
@export var knight_ui : Node
@export var bishop_ui : Node
@export var queen_ui : Node
@export var king_ui : Node

@export var b_capture : Node
@export var w_capture : Node

@export var b_win : Node
@export var w_win : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = 8
	
	var id = 0;
	for c in get_children():
		c.tile_id = Vector2i(id % columns, floor(id / columns))
		c.change_tile_type(0)
		id += 1
	
	set_active_unit(-1)

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

func set_active_unit(type : int):
	pawn_ui.visible = false
	rook_ui.visible = false
	knight_ui.visible = false
	bishop_ui.visible = false
	queen_ui.visible = false
	king_ui.visible = false
	
	if type == 0:
		pawn_ui.visible = true
	if type == 1:
		rook_ui.visible = true
	if type == 2:
		bishop_ui.visible = true
	if type == 3:
		knight_ui.visible = true
	if type == 4:
		queen_ui.visible = true
	if type == 5:
		king_ui.visible = true
