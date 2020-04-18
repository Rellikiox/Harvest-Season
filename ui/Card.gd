extends MarginContainer

export (Global.CardEnum) var card_type setget set_card_type

var card = null
var interactions_enabled = true


func _ready():
	set_card_type(card_type)
	$CardTexture.material = $CardTexture.material.duplicate()
	enable_interactions(true)
	

func enable_interactions(enabled):
	interactions_enabled = enabled
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND if interactions_enabled else Control.CURSOR_ARROW
	$CardTexture.material.set_shader_param('grayscale', not enabled)


func set_card_type(_card_type):
	card_type = _card_type
	match card_type:
		Global.CardEnum.PLANT_POTATO:
			card = Cards.PlantPotatoCard.new()
		Global.CardEnum.PLANT_PEAS:
			card = Cards.PlantPeasCard.new()
		Global.CardEnum.PLANT_CABBAGE:
			card = Cards.PlantCabbageCard.new()
		Global.CardEnum.PLANT_ONION:
			card = Cards.PlantOnionCard.new()
		Global.CardEnum.PLANT_BEET:
			card = Cards.PlantBeetCard.new()
		Global.CardEnum.PLACE_SPRINKLER:
			card = Cards.PlaceSprinklerCard.new()
		Global.CardEnum.DIG_GROUND:
			card = Cards.DigGroundCard.new()
			
	$CardTexture.texture = card.texture
	

func get_drag_data(_pos):
	if interactions_enabled:
		var icon = TextureRect.new()
		icon.texture = card.icon
		set_drag_preview(icon)
		return card
	else:
		return null
		

func _on_CardTexture_mouse_entered():
	if interactions_enabled:
		$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, -10, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()


func _on_CardTexture_mouse_exited():	
	if interactions_enabled:
		$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()
