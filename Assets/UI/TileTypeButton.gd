extends Button

@export var tileType : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(change_tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_tile():
	get_node("/root/GameState").change_custom_tile(tileType)
	
