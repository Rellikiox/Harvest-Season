extends MarginContainer

var PotatoIcon = preload('res://assets/potato-icon.png')

export (Global.CardEnum) var card_type setget set_card_type

var card = null


func set_card_type(card_type):
	match card_type:
		Global.CardEnum.PLANT_POTATO:
			card = Cards.PlantPotatoCard.new()
		Global.CardEnum.PLANT_LEGUMEN:
			card = Cards.PlantLegumenCard.new()
			
	$CardTexture.texture = card.texture
	

func get_drag_data(_pos):
	var icon = TextureRect.new()
	icon.texture = card.icon
	set_drag_preview(icon)
	
	return card


func _on_CardTexture_mouse_entered():
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, -10, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()


func _on_CardTexture_mouse_exited():	
	$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
