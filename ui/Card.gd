extends MarginContainer

export (Global.CardEnum) var card_type setget set_card_type

var card = null
var interactions_enabled = true



const CARD_TEXT = {
	Global.CardEnum.PLANT_POTATO: 
"""Max size: 3

When harvested:
 +2 points per tile
 +3 if max size""",
	Global.CardEnum.PLANT_PEAS: 
"""Max size: 5

When harvested:
 +1 point per tile
 +10 if max size""",
	Global.CardEnum.PLANT_CABBAGE: 
"""Max size: 3

When harvested:
 +4 points per tile
 +2 if max size""",
	Global.CardEnum.PLANT_ONION: 
"""Max size: 2

When harvested:
 +3 points per tile
 +3 if max size""",
	Global.CardEnum.PLANT_BEET: 
"""Max size: 1

When harvested:
 +7 points per tile""",
	Global.CardEnum.PLACE_SPRINKLER: 
"""Water adjacent crop beds.
16 total charges, 1 charge spent per turn per crop""",
	Global.CardEnum.DIG_GROUND: 
"""Transform dirt into plantable soil""",
	Global.CardEnum.DELETE_TILE: 
"""Convert any tile back into dirt""",
	Global.CardEnum.WATERING_CAN: 
"""Water single crop bed with one charge""",
	Global.CardEnum.SCYTHE: 
"""Harvest crop bed. Extra points for full beds""",
}


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
		Global.CardEnum.DELETE_TILE:
			card = Cards.DeleteTileCard.new()
		Global.CardEnum.WATERING_CAN:
			card = Cards.WateringCanCard.new()
		Global.CardEnum.SCYTHE:
			card = Cards.ScytheCanCard.new()
			
	$CardTexture.texture = card.texture
	$CardTexture/Description.text = CARD_TEXT[card_type]
	

func get_drag_data(_pos):
	if interactions_enabled:
		var icon = TextureRect.new()
		icon.texture = card.icon
		icon.rect_scale = Vector2(0.5, 0.5)
		set_drag_preview(icon)
		return card
	else:
		return null
		

func _on_CardTexture_mouse_entered():
	if interactions_enabled:
		$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, -64, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()


func _on_CardTexture_mouse_exited():	
	if interactions_enabled:
		$Tween.interpolate_property($CardTexture, 'margin_top', $CardTexture.margin_top, 0, 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()
