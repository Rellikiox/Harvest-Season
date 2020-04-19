extends Node


var deck = [
	Global.CardEnum.PLANT_BEET,
	Global.CardEnum.PLANT_BEET,
	Global.CardEnum.PLANT_BEET,
	Global.CardEnum.PLANT_PEAS,
	Global.CardEnum.PLANT_PEAS,
	Global.CardEnum.PLANT_PEAS,
	Global.CardEnum.PLANT_CABBAGE,
	Global.CardEnum.PLANT_CABBAGE,
	Global.CardEnum.PLANT_CABBAGE,
	Global.CardEnum.PLANT_ONION,
	Global.CardEnum.PLANT_ONION,
	Global.CardEnum.PLANT_ONION,
	Global.CardEnum.PLANT_POTATO,
	Global.CardEnum.PLANT_POTATO,
	Global.CardEnum.PLANT_POTATO,
	Global.CardEnum.PLACE_SPRINKLER,
	Global.CardEnum.WATERING_CAN,
	Global.CardEnum.WATERING_CAN,
	Global.CardEnum.WATERING_CAN,
	Global.CardEnum.WATERING_CAN,
	Global.CardEnum.WATERING_CAN,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.SCYTHE
#	Global.CardEnum.DELETE_TILE
]

var draw_pile = []
var hand = []
var discard_pile = []

func _init():
	draw_pile = deck.duplicate()
	draw_pile.shuffle()


func draw_cards(amount):
	for card in hand:
		discard_pile.append(card)
		
	hand = []
	for i in range(amount):
		if draw_pile.empty():
			replenish_draw_pile()
		hand.append(draw_pile.pop_front())
	
	return hand
	
	
func replenish_draw_pile():
	draw_pile = discard_pile
	draw_pile.shuffle()
	discard_pile = []
