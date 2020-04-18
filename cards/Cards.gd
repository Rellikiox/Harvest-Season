extends Node
class_name Cards



class BaseCard:	
	func can_be_placed(cell:Vector2, ground:TileMap):
		pass
		
	func place(cell:Vector2, ground:TileMap):
		pass
		

class PlantPotatoCard extends BaseCard:	
	var tile = Global.GroundTileEnum.POTATO
	
	func can_be_placed(cell:Vector2, ground:TileMap):
		return ground.get_cellv(cell) == Global.GroundTileEnum.SOIL

	func place(cell:Vector2, ground:TileMap):
		ground.set_cellv(cell, tile)
