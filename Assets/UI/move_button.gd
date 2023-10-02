extends Control

var id : Vector2i
var unit : Node
var affected_tiles : Array[Vector2i]
var terraforming_mode : int

var target_tile : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_tile != null:
		global_position = target_tile.global_position
	pass

func setup_move(new_unit, new_id, new_affected_tiles : Array[Vector2i], new_terraforming_mode, noMove : bool = false):
	id = new_id
	unit = new_unit
	affected_tiles = new_affected_tiles
	terraforming_mode = new_terraforming_mode
	if noMove:
		$Button.pressed.connect(get_node("/root/GameState").move_unit.bind(unit, unit.pos, affected_tiles, terraforming_mode))
	else:
		$Button.pressed.connect(get_node("/root/GameState").move_unit.bind(unit, id, affected_tiles, terraforming_mode))

func clickMove():
	pass
