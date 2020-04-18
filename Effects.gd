extends TileMap

signal crop_death

var water_offsets = [
	Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)
]


func increase_water(cell):
	var current_level = get_cellv(cell)
	if current_level >= Global.EffectsEnum.WATER_1 and current_level <= Global.EffectsEnum.WATER_FULL:
		set_cellv(cell, current_level + 1)


func decrease_water(cell):
	var current_level = get_cellv(cell)
	if current_level > Global.EffectsEnum.DEAD:
		var new_level = current_level - 1
		set_cellv(cell, new_level)
		if new_level == Global.EffectsEnum.DEAD:
			emit_signal('crop_death')
			
			
