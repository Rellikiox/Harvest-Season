extends Node2D

enum GroundTiles {EMPTY = -1, DIRT, SOIL, POTATO, ONION, LEGUMEN, ROOT, BRASSICA, SPRINKLER}



func _physics_process(delta):
	$UI/UI/Points.text = '%d Points' % calculate_points()
	

func calculate_points():
	var potatoes = len($TileMap.get_used_cells_by_id(GroundTiles.POTATO))
	var onions = len($TileMap.get_used_cells_by_id(GroundTiles.ONION))
	var legumens = len($TileMap.get_used_cells_by_id(GroundTiles.LEGUMEN))
	var roots = len($TileMap.get_used_cells_by_id(GroundTiles.ROOT))
	var brassica = len($TileMap.get_used_cells_by_id(GroundTiles.BRASSICA))
	return potatoes + onions + legumens + roots + brassica
