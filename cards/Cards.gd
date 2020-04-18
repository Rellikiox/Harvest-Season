extends Node
class_name Cards



class BaseCard:	
	func can_be_placed(cell:Vector2, ground:TileMap):
		pass
		
	func place(cell:Vector2, ground:TileMap):
		pass
		

class PlantPotatoCard extends BaseCard:	
	var tile = Global.GroundTileEnum.POTATO
	var icon = preload('res://assets/potato-icon.png')
	var texture = preload('res://assets/potato-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)


class PlantPeasCard extends BaseCard:	
	var tile = Global.GroundTileEnum.PEAS
	var icon = preload('res://assets/peas-icon.png')
	var texture = preload('res://assets/peas-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)


class PlantCabbageCard extends BaseCard:	
	var tile = Global.GroundTileEnum.CABBAGE
	var icon = preload('res://assets/cabbage-icon.png')
	var texture = preload('res://assets/cabbage-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)



class PlantOnionCard extends BaseCard:	
	var tile = Global.GroundTileEnum.ONION
	var icon = preload('res://assets/onion-icon.png')
	var texture = preload('res://assets/onion-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)




class PlantBeetCard extends BaseCard:	
	var tile = Global.GroundTileEnum.BEET
	var icon = preload('res://assets/beet-icon.png')
	var texture = preload('res://assets/beet-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)
