extends Node
class_name Cards



class BaseCard:	
	func can_be_placed(cell:Vector2, ground:TileMap):
		pass
		
	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		pass
		

class PlantPotatoCard extends BaseCard:	
	var tile = Global.GroundTileEnum.POTATO
	var icon = preload('res://assets/potato-icon.png')
	var texture = preload('res://assets/potato-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantPeasCard extends BaseCard:	
	var tile = Global.GroundTileEnum.PEAS
	var icon = preload('res://assets/peas-icon.png')
	var texture = preload('res://assets/peas-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantCabbageCard extends BaseCard:	
	var tile = Global.GroundTileEnum.CABBAGE
	var icon = preload('res://assets/cabbage-icon.png')
	var texture = preload('res://assets/cabbage-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)



class PlantOnionCard extends BaseCard:	
	var tile = Global.GroundTileEnum.ONION
	var icon = preload('res://assets/onion-icon.png')
	var texture = preload('res://assets/onion-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlantBeetCard extends BaseCard:	
	var tile = Global.GroundTileEnum.BEET
	var icon = preload('res://assets/beet-icon.png')
	var texture = preload('res://assets/beet-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.WATER_3)


class PlaceSprinklerCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SPRINKLER
	var icon = preload('res://assets/sprinkler-icon.png')
	var texture = preload('res://assets/sprinkler-card.png')
	var water_offsets = [
		Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)
	]
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) in [Global.GroundTileEnum.DIRT, Global.GroundTileEnum.SOIL]

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		for offset in water_offsets:
			var other_cell = cell + offset
			if ground.cell_has_plant(other_cell):
				effects.increase_water(other_cell)


class DigGroundCard extends BaseCard:	
	var tile = Global.GroundTileEnum.SOIL
	var icon = preload('res://assets/dig-icon.png')
	var texture = preload('res://assets/dig-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.DIRT

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)


class DeleteTileCard extends BaseCard:	
	var tile = Global.GroundTileEnum.DIRT
	var icon = preload('res://assets/delete-icon.png')
	var texture = preload('res://assets/delete-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.cell_has_plant(cell) or ground.get_cellv(cell) == Global.GroundTileEnum.SPRINKLER

	func place(cell:Vector2, ground:TileMap, effects:TileMap):
		ground.set_cellv(cell, tile)
		effects.set_cellv(cell, Global.EffectsEnum.EMPTY)
