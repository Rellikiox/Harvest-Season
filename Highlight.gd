extends TileMap


func highlight_tiles(cells, value=Global.HighlightTileEnum.HIGHLIGHT):
	clear()
	for _cell in cells:
		set_cellv(_cell, value)
		update_bitmask_area(_cell)
