extends Control

var color 
var tile_id : Vector2i
var tile_type : int # 0-nominal; 1-Wall; 2-Pit; 3-Ice

var black_tile : Node
var white_tile : Node
var wall_tile : Node
var pit_tile : Node
var ice_tile : Node
var border_tile : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	# Mostly just sending the id back so the game state can handle it
	$Button.pressed.connect(get_node("/root/GameState").click_tile.bind(tile_id))
	
	black_tile = $Black
	white_tile = $White
	wall_tile = $Wall
	pit_tile = $Pit
	ice_tile = $Ice
	border_tile = $Border
	
	change_tile_type(0)

func change_tile_type(new_type : int):
	tile_type = new_type
	
	black_tile.visible = false
	white_tile.visible = false
	wall_tile.visible = false
	pit_tile.visible = false
	ice_tile.visible = false
	border_tile.visible = false
	
	if new_type == 0 && (tile_id.x + tile_id.y) % 2 == 1:
		black_tile.visible = true
	if new_type == 0 && (tile_id.x + tile_id.y) % 2 == 0:
		white_tile.visible = true
	if new_type == 1:
		wall_tile.visible = true
	if new_type == 2:
		pit_tile.visible = true
	if new_type == 3:
		ice_tile.visible = true
	if new_type == 4:
		border_tile.visible = true
