extends TileMap

signal crops_harvested


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


func cell_has(cell:Vector2, tile:int):
	return get_cellv(cell) == tile


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
	
	
func potential_crop_bed(target, crop):
	var prev_value = get_cellv(target)
	set_cellv(target, crop)
	var crop_bed = get_adjacent_of_same_type(target)
	set_cellv(target, prev_value)
	return crop_bed


func get_adjacent_of_same_type(target):
	var crop_type = get_cellv(target)
	var open_set = [target]
	var visited = []
	var cells = []
	while not open_set.empty():
		var cell = open_set.pop_front()
		if cell in visited:
			continue
		visited.append(cell)
		if get_cellv(cell) == crop_type and $Effects.get_cellv(cell) != Global.EffectsEnum.DEAD:
			cells.append(cell)
			for _cell in get_neighbours(cell):
				open_set.append(_cell)
	return cells


func water_adjacent_crops(cell):
	for _cell in get_crop_beds_around_cell(cell):
		$Effects.increase_water(_cell)
				
				
func get_crop_beds_around_cell(cell):
	var cells = []
	var neighbours = get_neighbours(cell)
	for neighbour_cell in neighbours:
		if cell_has_crop(neighbour_cell):
			var crop_segment = get_adjacent_of_same_type(neighbour_cell)
			cells += crop_segment
	return cells


func harvest_crops(cells):
	if len(cells) == 0:
		return
		
	var type = get_cellv(cells[0])
	for cell in cells:
		set_cellv(cell, Global.GroundTileEnum.SOIL)
		$Effects.set_cellv(cell, Global.EffectsEnum.EMPTY)
		
	emit_signal('crops_harvested', type, len(cells))


func plant_crop(cell, crop):
	set_cellv(cell, crop)
	$Effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


func destroy_cell(cell):
	set_cellv(cell, Global.GroundTileEnum.DIRT)
	$Effects.set_cellv(cell, Global.EffectsEnum.EMPTY)


func water_crop_bed(cell):
	var bed = get_adjacent_of_same_type(cell)
	for crop in bed:
		$Effects.increase_water(crop)
