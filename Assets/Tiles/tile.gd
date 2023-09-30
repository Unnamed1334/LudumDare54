extends Control

var color 
var tile_id : Vector2i
var tile_type : int

var blank_tile : Node
var wall_tile : Node
var pit_tile : Node
var ice_tile : Node
var boarder_tile : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Mostly just sending the id back so the game state can handle it
	$Button.pressed.connect(get_node("/root/GameState").click_tile.bind(tile_id))
	
	blank_tile = $Blank
	wall_tile = $Wall
	pit_tile = $Pit
	ice_tile = $Ice
	boarder_tile = $Border
	
	change_tile_type(0)

func change_tile_type(new_type : int):
	tile_type = new_type
	
	blank_tile.visible = false
	wall_tile.visible = false
	pit_tile.visible = false
	ice_tile.visible = false
	boarder_tile.visible = false
	
	if new_type == 0:
		blank_tile.visible = true
	if new_type == 1:
		wall_tile.visible = true
	if new_type == 2:
		pit_tile.visible = true
	if new_type == 3:
		ice_tile.visible = true
	if new_type == 4:
		boarder_tile.visible = true
