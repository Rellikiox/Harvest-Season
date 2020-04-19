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
		
	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		pass
		

class PlantPotatoCard extends BaseCard:	
	var tile = Global.GroundTileEnum.POTATO
	var icon = preload('res://assets/potato-icon.png')
	var texture = preload('res://assets/potato-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantPeasCard extends BaseCard:	
	var tile = Global.GroundTileEnum.PEAS
	var icon = preload('res://assets/peas-icon.png')
	var texture = preload('res://assets/peas-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantCabbageCard extends BaseCard:	
	var tile = Global.GroundTileEnum.CABBAGE
	var icon = preload('res://assets/cabbage-icon.png')
	var texture = preload('res://assets/cabbage-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)



class PlantOnionCard extends BaseCard:	
	var tile = Global.GroundTileEnum.ONION
	var icon = preload('res://assets/onion-icon.png')
	var texture = preload('res://assets/onion-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantBeetCard extends BaseCard:	
	var tile = Global.GroundTileEnum.BEET
	var icon = preload('res://assets/beet-icon.png')
	var texture = preload('res://assets/beet-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlaceSprinklerCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SPRINKLER
	var icon = preload('res://assets/sprinkler-icon.png')
	var texture = preload('res://assets/sprinkler-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) in [Global.GroundTileEnum.DIRT, Global.GroundTileEnum.SOIL]

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		ground.water_adjacent(cell)


class DigGroundCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SOIL
	var icon = preload('res://assets/dig-icon.png')
	var texture = preload('res://assets/dig-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.DIRT

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)


class DeleteTileCard extends BaseCard:	
	var tile = Global.GroundTileEnum.DIRT
	var icon = preload('res://assets/delete-icon.png')
	var texture = preload('res://assets/delete-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_crop(cell) or ground.get_cellv(cell) == Global.GroundTileEnum.SPRINKLER

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.EMPTY)



class WateringCanCard extends BaseCard:	
	var icon = preload('res://assets/wateringcan-icon.png')
	var texture = preload('res://assets/wateringcan-card.png')
	
	func on_tile_hover(cell:Vector2, ground:TileMap, highlight:TileMap):
		.on_tile_hover(cell, ground, highlight)
		
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_crop(cell)

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		effects.increase_water(cell)




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

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		var crops = ground.get_adjacent_of_same_type(cell)
		ground.harvest_crops(crops)
