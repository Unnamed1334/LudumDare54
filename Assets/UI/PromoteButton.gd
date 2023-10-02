extends Button

@export var promoteType : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(change_promote)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_promote():
	get_node("/root/GameState").promote_type = promoteType
