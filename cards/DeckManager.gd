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
	Global.CardEnum.PLACE_SPRINKLER,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.DIG_GROUND,
	Global.CardEnum.DELETE_TILE,
	Global.CardEnum.DELETE_TILE,
	Global.CardEnum.DELETE_TILE
]

var draw_pile = []
var hand = []
var discard_pile = []

func _init():
	randomize()
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
