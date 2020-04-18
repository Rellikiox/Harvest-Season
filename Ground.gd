extends TileMap


var Crops = [
	Global.GroundTileEnum.POTATO,
	Global.GroundTileEnum.ONION,
	Global.GroundTileEnum.PEAS,
	Global.GroundTileEnum.BEET,
	Global.GroundTileEnum.CABBAGE
]
var neighbour_offsets = [
	Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)
]


func is_valid_cell(cell:Vector2):
	return get_cellv(cell) != Global.GroundTileEnum.EMPTY


func cell_has_crop(cell:Vector2):
	return get_cellv(cell) in Crops


func get_crop_cells():
	var cells = []
	for crop_type in Crops:
		cells += get_used_cells_by_id(crop_type)
	return cells


func get_neighbours(cell):
	var cells = []
	for offset in neighbour_offsets:
		if is_valid_cell(cell + offset):
			cells.append(cell + offset)
	return cells


func get_adjacent_of_same_type(target):
	var type = get_cellv(target)
	var open_set = [target]
	var visited = []
	var cells = []
	while not open_set.empty():
		var cell = open_set.pop_front()
		if cell in visited:
			continue
		visited.append(cell)
		if get_cellv(cell) == type and $Effects.get_cellv(cell) != Global.EffectsEnum.DEAD:
			cells.append(cell)
			for _cell in get_neighbours(cell):
				open_set.append(_cell)
	return cells


func water_adjacent(cell):
	var neighbours = get_neighbours(cell)
	for neighbour_cell in neighbours:
		if cell_has_crop(neighbour_cell):
			var crop_segment = get_adjacent_of_same_type(neighbour_cell)
			for _cell in crop_segment:
				$Effects.increase_water(_cell)
