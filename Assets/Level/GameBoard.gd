extends GridContainer

@export var blank_tile : PackedScene
@export var wall_tile : PackedScene
@export var pit_tile : PackedScene
@export var ice_tile : PackedScene
@export var boarder_tile : PackedScene

@export var test_pawn : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create the tiles
	columns = 8
	for x in columns * columns:
		var tile_object = blank_tile.instantiate()
		add_child.call_deferred(tile_object)
	
	# Place the units
	for x in columns:
		var pawn_object = test_pawn.instantiate()
		get_parent().add_child.call_deferred(pawn_object)
		pawn_object = test_pawn.instantiate()
		get_parent().add_child.call_deferred(pawn_object)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_tile_pos() -> void:
	pass
