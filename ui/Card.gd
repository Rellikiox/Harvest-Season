extends MarginContainer

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


func _on_CardTexture_mouse_entered():
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, -10, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()


func _on_CardTexture_mouse_exited():	
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
