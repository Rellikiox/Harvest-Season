extends Node2D

var UITiles = Global.UITileEnum
var GroundTiles = Global.GroundTileEnum
var HighlightTiles = Global.HighlightTileEnum

var mouse_up = true
var finished = false


# Engine Callbacks

func _ready():
	randomize()
	$UI.connect('drag_position', self, '_on_card_drag')
	$UI.connect('drop_position', self, '_on_card_drop')
	$UI.connect('end_turn_button', $TurnManager, 'end_turn')
	$Ground/Effects.connect('crop_death', $TurnManager, '_on_crop_death')
	$Ground.connect('crops_harvested', $TurnManager, '_on_crop_harvested')
	init_tilemaps()
	$TurnManager.init(self, $UI)


func _physics_process(delta):
	if finished:
		return
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
	
	card.on_tile_hover(cell, $Ground, $Ground/Highlight)


func _on_card_drop(_position, card:Cards.BaseCard):
	$Ground/UI.clear()
	
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not $Ground.is_valid_cell(cell):
		return
	
	if card.can_be_placed(cell, $Ground):
		card.place(cell, $Ground)
		$TurnManager.card_played(card)
	
	
# Tileset management	

func init_tilemaps():
	# Clear any UI
	$Ground/UI.clear()
	
	# Clear any effects
	$Ground/Effects.clear()
	$Ground/SprinklerUI.clear()
	
	# Clear and init the ground
	$Ground.clear()
	for x in range(7):
		for y in range(7):
			$Ground.set_cell(x, y, GroundTiles.DIRT)
	
	for x in range(2, 5):
		for y in range(2, 5):
			$Ground.set_cell(x, y, GroundTiles.SOIL)
			
	var extra_soil_placed = 0
	while extra_soil_placed <= 13:
		var x = randi() % 7
		var y = randi() % 7
		if $Ground.get_cell(x, y) == GroundTiles.DIRT:
			$Ground.set_cell(x, y, GroundTiles.SOIL)
			extra_soil_placed += 1
	
	
func highlight_crops():
	if not mouse_up:
		return
	$Ground/Highlight.clear()	
	
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if $Ground.cell_has_crop(cell):
		var adjacent_crops = $Ground.get_adjacent_of_same_type(cell)
		$Ground/Highlight.highlight_tiles(adjacent_crops)
	elif $Ground.cell_has(cell, GroundTiles.SPRINKLER):
		var crop_beds = $Ground.get_sprinkler_targets(cell)
		$Ground/Highlight.highlight_tiles(crop_beds, HighlightTiles.WATER)
		$Ground/Highlight.highlight_tiles([cell], HighlightTiles.HIGHLIGHT, false)
	

# Gameplay Methods

func process_tiles():
	var water_offsets = [
		Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)
	]
	for cell in $Ground.get_used_cells_by_id(GroundTiles.SPRINKLER):
		$Ground.trigger_sprinkler(cell)
				
	for cell in $Ground.get_crop_cells():
		$Ground/Effects.decrease_water(cell)
		
