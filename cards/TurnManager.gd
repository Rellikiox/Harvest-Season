extends Node

var DeckManager = preload('res://cards/DeckManager.gd')

export (int) var ACTIONS_PER_TURN = 3
export (int) var MAX_LIVES = 3

var Game = null
var UI = null
var Deck = null

var actions_left = 0
var lives_left = 0
var points = 0
var turns = 0


func init(_game, _ui):
	lives_left = MAX_LIVES
	Game = _game
	UI = _ui
	Deck = DeckManager.new()
	UI.set_points(0)
	trigger_turn_start()
	replenish_actions()
	

func end_turn():
	UI.discard_cards()
	Game.process_tiles()
	trigger_turn_start()
	replenish_actions()
	
	
func card_played(card):
	UI.discard_card(card)
	actions_left -= 1
	if actions_left == 0:
		UI.disable_cards()
		UI.enable_end_turn()
	UI.set_actions(actions_left, ACTIONS_PER_TURN)


func replenish_actions():
	actions_left = ACTIONS_PER_TURN
	UI.set_actions(actions_left, ACTIONS_PER_TURN)
	
	
func trigger_turn_start():
	var new_cards = Deck.draw_cards(5)
	turns += 1
	UI.set_turns(turns)
	UI.set_cards(new_cards)
	UI.enable_end_turn(false)
	
	
func _on_crop_harvested(type, amount):
	points += pow(amount, 2)
	UI.set_points(points)
	
	
func _on_crop_death():
	lives_left -= 1
	UI.set_n_lives(lives_left)
	if lives_left <= 0:
		trigger_game_over()
		
		
func trigger_game_over():
	UI.display_gameover(Game.calculate_points())
	Game.finished = true
