extends TileMap


var Crops = [
	Global.GroundTileEnum.POTATO,
	Global.GroundTileEnum.ONION,
	Global.GroundTileEnum.PEAS,
	Global.GroundTileEnum.BEET,
	Global.GroundTileEnum.CABBAGE
]


func is_valid_cell(cell:Vector2):
	return get_cellv(cell) != Global.GroundTileEnum.EMPTY


func cell_has_plant(cell:Vector2):
	return get_cellv(cell) in Crops


func get_crop_cells():
	var cells = []
	for crop_type in Crops:
		cells += get_used_cells_by_id(crop_type)
	return cells
