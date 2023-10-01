extends Control

var id : Vector2i
var unit : Node

var target_tile : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_tile != null:
		global_position = target_tile.global_position
	pass

func setup_move(new_unit, new_id):
	id = new_id
	unit = new_unit
	$Button.pressed.connect(get_node("/root/GameState").move_unit.bind(unit, id))

func clickMove():
	pass
