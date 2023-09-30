extends GridContainer

@export var blank_tile: PackedScene
@export var wall_tile: PackedScene
@export var pit_tile: PackedScene
@export var ice_tile: PackedScene
@export var boarder_tile: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	columns = 8
	for x in columns * columns:
		var instancedObject = blank_tile.instantiate()
		add_child(instancedObject)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
