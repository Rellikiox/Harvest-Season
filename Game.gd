extends Node2D

enum GroundTiles {EMPTY = -1, DIRT, SOIL, POTATO, ONION, LEGUMEN, ROOT, BRASSICA, SPRINKLER}
enum UITiles {EMPTY = -1, HIGHLIGHT}


# Engine Callbacks

func _ready():
	$UI/UI.connect('drag_position', self, '_on_card_drag')
	$UI/UI.connect('drop_position', self, '_on_card_drop')
	
	reset_land()
	reset_ui()


func _physics_process(delta):
	$UI/UI/Points.text = '%d Points' % calculate_points()


func _input(event):
	if event.is_action_pressed('restart'):
		get_tree().reload_current_scene()
		

# Interactions with card dragging

func _on_card_drag(_position, card):
	var tilemap_position = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not is_valid_cell(tilemap_position):
		return
	
	$Ground/UI.clear()
	$Ground/UI.set_cellv(tilemap_position, UITiles.HIGHLIGHT)


func _on_card_drop(_position, card):
	var tilemap_position = $Ground.world_to_map($Ground.get_local_mouse_position())
	if not is_valid_cell(tilemap_position):
		return
	
	$Ground.set_cellv(tilemap_position, card)
	
	
# Tileset management	

func is_valid_cell(cell):
	return cell.x >= 0 and cell.x <= 6 and cell.y >= 0 and cell.y <= 6
	

func reset_land():
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
			
	

func reset_ui():
	$Ground/UI.clear()
	

# Gameplay Methods

func calculate_points():
	var potatoes = len($Ground.get_used_cells_by_id(GroundTiles.POTATO))
	var onions = len($Ground.get_used_cells_by_id(GroundTiles.ONION))
	var legumens = len($Ground.get_used_cells_by_id(GroundTiles.LEGUMEN))
	var roots = len($Ground.get_used_cells_by_id(GroundTiles.ROOT))
	var brassica = len($Ground.get_used_cells_by_id(GroundTiles.BRASSICA))
	return potatoes + onions + legumens + roots + brassica
