extends Node2D

var UITiles = Global.UITileEnum
var GroundTiles = Global.GroundTileEnum



# Engine Callbacks

func _ready():
	$UI/UI.connect('drag_position', self, '_on_card_drag')
	$UI/UI.connect('drop_position', self, '_on_card_drop')
	$UI/UI.connect('end_turn_button', $TurnManager, 'end_turn')
	
	init_tilemaps()
	$TurnManager.init(self, $UI/UI)


func _physics_process(delta):
	$UI/UI/Points.text = '%d Points' % calculate_points()


func _input(event):
	if event.is_action_pressed('restart'):
		get_tree().reload_current_scene()
		

# Interactions with card dragging

func _on_card_drag(_position, card):
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not is_valid_cell(cell):
		return
	
	$Ground/UI.clear()
	if card.can_be_placed(cell, $Ground):
		$Ground/UI.set_cellv(cell, UITiles.HIGHLIGHT)
	else:
		$Ground/UI.set_cellv(cell, UITiles.INVALID)


func _on_card_drop(_position, card:Cards.BaseCard):
	$Ground/UI.clear()
	
	var cell = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not is_valid_cell(cell):
		return
	
	if card.can_be_placed(cell, $Ground):
		card.place(cell, $Ground, $Ground/Effects)
		$TurnManager.action_spent()
	
	
# Tileset management	

func is_valid_cell(cell):
	return cell.x >= 0 and cell.x <= 6 and cell.y >= 0 and cell.y <= 6
	

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
	

# Gameplay Methods

func calculate_points():
	var potatoes = len($Ground.get_used_cells_by_id(GroundTiles.POTATO))
	var onions = len($Ground.get_used_cells_by_id(GroundTiles.ONION))
	var peas = len($Ground.get_used_cells_by_id(GroundTiles.PEAS))
	var beets = len($Ground.get_used_cells_by_id(GroundTiles.BEET))
	var cabbage = len($Ground.get_used_cells_by_id(GroundTiles.CABBAGE))
	return potatoes + onions + peas + beets + cabbage


func process_tiles():
	for cell in $Ground/Effects.get_used_cells():
		var level = $Ground/Effects.get_cellv(cell)
		if level == Global.EffectsEnum.DEAD:
			continue
		
		$Ground/Effects.set_cellv(cell, level - 1)
