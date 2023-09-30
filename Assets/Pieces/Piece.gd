extends Control

var slected : bool

var pos : Vector2i

@export var move_icon: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Get the places this unit can move.
func place_moves() -> Array[Node]:
	var array : Array[Node] = []
	return array
