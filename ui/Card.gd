extends MarginContainer

var PotatoIcon = preload('res://assets/potato-icon.png')
var Cards = preload('res://cards/Cards.gd')

export (Global.CardEnum) var card_type 


func get_drag_data(_pos):
	var icon = TextureRect.new()
	icon.texture = PotatoIcon
	set_drag_preview(icon)
	
	return Cards.PlantPotatoCard.new()


func _on_CardTexture_mouse_entered():
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, -10, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()


func _on_CardTexture_mouse_exited():	
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
