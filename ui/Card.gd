extends Control

var Game = preload("res://Game.gd")
var PotatoIcon = preload("res://assets/potato-icon.png")


func get_drag_data(_pos):
	var icon = TextureRect.new()
	icon.texture = PotatoIcon
	set_drag_preview(icon)
	
	return Game.GroundTiles.POTATO
	
	
func can_drop_data(_pos, data):
	return true


func drop_data(_pos, data):
	print(_pos)
	print(data)
