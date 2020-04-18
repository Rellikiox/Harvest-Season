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

		

class PlantLegumenCard extends BaseCard:	
	var tile = Global.GroundTileEnum.LEGUMEN
	var icon = preload('res://assets/peas-icon.png')
	var texture = preload('res://assets/peas-card.png')
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)
