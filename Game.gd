extends Node2D

var UITiles = Global.UITileEnum
var GroundTiles = Global.GroundTileEnum


var mouse_up = true
var finished = false


# Engine Callbacks

func _ready():
	$UI.connect('drag_position', self, '_on_card_drag')
	$UI.connect('drop_position', self, '_on_card_drop')
	$UI.connect('end_turn_button', $TurnManager, 'end_turn')
	$Ground/Effects.connect('crop_death', $TurnManager, '_on_crop_death')
	
	init_tilemaps()
	$TurnManager.init(self, $UI)


func _physics_process(delta):
	if finished:
		return
	$UI.set_points(calculate_points())
	highlight_crops()


func _input(event):
	if event.is_action_pressed('restart'):
		get_tree().reload_current_scene()
	
	if finished:
		return
			
	if event.is_action_pressed('click'):
		mouse_up = false
	elif event.is_action_released('click'):
		mouse_up = true


# Interactions with card dragging

func _on_card_drag(_position, card):
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not $Ground.is_valid_cell(cell):
		return
	
	$Ground/UI.clear()
	if card.can_be_placed(cell, $Ground):
		$Ground/UI.set_cellv(cell, UITiles.HIGHLIGHT)
	else:
		$Ground/UI.set_cellv(cell, UITiles.INVALID)


func _on_card_drop(_position, card:Cards.BaseCard):
	$Ground/UI.clear()
	
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not $Ground.is_valid_cell(cell):
		return
	
	if card.can_be_placed(cell, $Ground):
		card.place(cell, $Ground, $Ground/Effects)
		$TurnManager.card_played(card)
	
	
# Tileset management	

func init_tilemaps():
	# Clear any UI
	$Ground/UI.clear()
	
	# Clear any effects
	$Ground/Effects.clear()
	
	# Clear and init the ground
	$Ground.clear()
	for x in range(7):
		for y in range(7):
			$Ground.set_cell(x, y, GroundTiles.DIRT)
	
	for x in range(2, 5):
		for y in range(2, 5):
			$Ground.set_cell(x, y, GroundTiles.SOIL)
			
	var extra_soil_placed = 0
	while extra_soil_placed <= 8:
		var x = randi() % 7
		var y = randi() % 7
		if $Ground.get_cell(x, y) == GroundTiles.DIRT:
			$Ground.set_cell(x, y, GroundTiles.SOIL)
			extra_soil_placed += 1
	
	
func highlight_crops():
	if not mouse_up:
		return
	$Ground/UI.clear()	
	
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if $Ground.cell_has_crop(cell):
		var adjacent_crops = $Ground.get_adjacent_of_same_type(cell)
		for _cell in adjacent_crops:
			$Ground/UI.set_cellv(_cell, UITiles.ADJACENT_HIGHLIGHT)
	

# Gameplay Methods

func calculate_points():
	var potatoes = len($Ground.get_used_cells_by_id(GroundTiles.POTATO))
	var onions = len($Ground.get_used_cells_by_id(GroundTiles.ONION))
	var peas = len($Ground.get_used_cells_by_id(GroundTiles.PEAS))
	var beets = len($Ground.get_used_cells_by_id(GroundTiles.BEET))
	var cabbage = len($Ground.get_used_cells_by_id(GroundTiles.CABBAGE))
	return potatoes + onions + peas + beets + cabbage


func process_tiles():
	var water_offsets = [
		Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)
	]
	for cell in $Ground.get_used_cells_by_id(GroundTiles.SPRINKLER):
		$Ground.water_adjacent(cell)
				
	for cell in $Ground.get_crop_cells():
		$Ground/Effects.decrease_water(cell)
