extends TileMap


func increase_water(cell):
	var current_level = get_cellv(cell)
	if current_level >= Global.EffectsEnum.WATER_1 and current_level < Global.EffectsEnum.WATER_3:
		set_cellv(cell, current_level + 1)

func decrease_water(cell):
	var current_level = get_cellv(cell)
	if current_level > Global.EffectsEnum.DEAD:
		set_cellv(cell, current_level - 1)
