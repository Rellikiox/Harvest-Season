extends Node
class_name Cards



class BaseCard:	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		if can_be_placed(cell, ground):
			highlight.highlight_tiles([cell])
		else:
			highlight.highlight_tiles([cell], Global.HighlightTileEnum.INVALID)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		pass
		
	func place(cell:Vector2, ground:TileMap):
		pass
		

class BasePlantCard extends BaseCard:		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.plant_crop(cell, self.tile)
		

class PlantPotatoCard extends BasePlantCard:	
	var tile = Global.GroundTileEnum.POTATO
	var icon = preload('res://assets/potato-icon.png')
	var texture = preload('res://assets/potato-card.png')
	

class PlantPeasCard extends BasePlantCard:	
	var tile = Global.GroundTileEnum.PEAS
	var icon = preload('res://assets/peas-icon.png')
	var texture = preload('res://assets/peas-card.png')


class PlantCabbageCard extends BasePlantCard:	
	var tile = Global.GroundTileEnum.CABBAGE
	var icon = preload('res://assets/cabbage-icon.png')
	var texture = preload('res://assets/cabbage-card.png')


class PlantOnionCard extends BasePlantCard:	
	var tile = Global.GroundTileEnum.ONION
	var icon = preload('res://assets/onion-icon.png')
	var texture = preload('res://assets/onion-card.png')
	

class PlantBeetCard extends BasePlantCard:	
	var tile = Global.GroundTileEnum.BEET
	var icon = preload('res://assets/beet-icon.png')
	var texture = preload('res://assets/beet-card.png')
	

class PlaceSprinklerCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SPRINKLER
	var icon = preload('res://assets/sprinkler-icon.png')
	var texture = preload('res://assets/sprinkler-card.png')
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) in [Global.GroundTileEnum.DIRT, Global.GroundTileEnum.SOIL]

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)
		ground.water_adjacent_crops(cell)


class DigGroundCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SOIL
	var icon = preload('res://assets/dig-icon.png')
	var texture = preload('res://assets/dig-card.png')
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.DIRT

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)


class DeleteTileCard extends BaseCard:	
	var icon = preload('res://assets/delete-icon.png')
	var texture = preload('res://assets/delete-card.png')
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_crop(cell) or ground.get_cellv(cell) == Global.GroundTileEnum.SPRINKLER

	func place(cell:Vector2, ground:TileMap):
		ground.destroy_cell(cell)


class WateringCanCard extends BaseCard:	
	var icon = preload('res://assets/wateringcan-icon.png')
	var texture = preload('res://assets/wateringcan-card.png')
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_crop(cell)

	func place(cell:Vector2, ground:TileMap):
		ground.water_single_crop(cell)



class ScytheCanCard extends BaseCard:	
	var icon = preload('res://assets/scythe-icon.png')
	var texture = preload('res://assets/scythe-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		if can_be_placed(cell, ground):
			var crops = ground.get_adjacent_of_same_type(cell)
			highlight.highlight_tiles(crops)
		else:
			highlight.highlight_tiles([cell], Global.HighlightTileEnum.INVALID)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_crop(cell)

	func place(cell:Vector2, ground:TileMap):
		var crops = ground.get_adjacent_of_same_type(cell)
		ground.harvest_crops(crops)
