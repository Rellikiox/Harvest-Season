extends Node



export (int) var ACTIONS_PER_TURN = 3

var Game = null
var UI = null

var actions_left = 0

func init(_game, _ui):
	Game = _game
	UI = _ui
	trigger_turn_start()
	replenish_actions()
	

func end_turn():
	Game.process_tiles()
	trigger_turn_start()
	replenish_actions()
	
	
func action_spent():
	actions_left -= 1
	if actions_left == 0:
		UI.disable_cards()
	UI.set_actions(actions_left, ACTIONS_PER_TURN)


func replenish_actions():
	actions_left = ACTIONS_PER_TURN
	UI.enable_cards()
	UI.set_actions(actions_left, ACTIONS_PER_TURN)
	
	
func trigger_turn_start():
	pass
