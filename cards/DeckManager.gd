extends Node


var deck = [
	Global.CardEnum.PLANT_BEET,
	Global.CardEnum.PLANT_CABBAGE,
	Global.CardEnum.PLANT_ONION,
	Global.CardEnum.PLANT_PEAS,
	Global.CardEnum.PLANT_POTATO
]
var index = 0


func _init():
	print('asd')


func draw_cards(amount):
	var cards = deck.slice(index, index + amount - 1)
	index = (index + amount) % len(deck)
	return cards
	
