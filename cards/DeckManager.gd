extends Node


var crops = [
	Global.CardEnum.PLANT_BEET,
	Global.CardEnum.PLANT_PEAS,
	Global.CardEnum.PLANT_CABBAGE,
	Global.CardEnum.PLANT_ONION,
	Global.CardEnum.PLANT_POTATO
]
var deck = {
	Global.CardEnum.PLANT_BEET: 3,
	Global.CardEnum.PLANT_PEAS: 3,
	Global.CardEnum.PLANT_CABBAGE: 3,
	Global.CardEnum.PLANT_ONION: 3,
	Global.CardEnum.PLANT_POTATO: 3,
	Global.CardEnum.PLACE_SPRINKLER: 1,
	Global.CardEnum.WATERING_CAN: 5,
	Global.CardEnum.DIG_GROUND: 3,
	Global.CardEnum.HARVEST_CROP: 5,
	Global.CardEnum.DELETE_TILE: 1
}

var draw_pile = []
var hand = []
var discard_pile = []

func _init():
	for card in deck:
		for count in range(deck[card]):
			draw_pile.append(card)
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
