extends Node2D

enum GroundTiles {EMPTY = -1, DIRT, SOIL, POTATO, ONION, LEGUMEN, ROOT, BRASSICA, SPRINKLER}
enum UITiles {EMPTY = -1, HIGHLIGHT}


func _ready():
	$UI/UI.connect('drag_position', self, '_on_card_drag')
	$UI/UI.connect('drop_position', self, '_on_card_drop')


func _physics_process(delta):
	$UI/UI/Points.text = '%d Points' % calculate_points()
	

func calculate_points():
	var potatoes = len($Ground.get_used_cells_by_id(GroundTiles.POTATO))
	var onions = len($Ground.get_used_cells_by_id(GroundTiles.ONION))
	var legumens = len($Ground.get_used_cells_by_id(GroundTiles.LEGUMEN))
	var roots = len($Ground.get_used_cells_by_id(GroundTiles.ROOT))
	var brassica = len($Ground.get_used_cells_by_id(GroundTiles.BRASSICA))
	return potatoes + onions + legumens + roots + brassica


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
	

func is_valid_cell(cell):
	return cell.x >= 0 and cell.x <= 6 and cell.y >= 0 and cell.y <= 6
	
