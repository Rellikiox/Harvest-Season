extends Control

signal drag_position
signal drop_position

signal end_turn_button


func set_actions(left, total):
	$Actions.text = '%d/%d\nActions left' % [left, total]
	
	
func enable_cards():
	for card in $CardContainer.get_children():
		card.enable_interactions(true)
	

func disable_cards():
	for card in $CardContainer.get_children():
		card.enable_interactions(false)


func can_drop_data(_position, data):
	emit_signal("drag_position", _position, data)
	return true


func drop_data(_position, data):	
	emit_signal("drop_position", _position, data)


func _on_End_Turn_pressed():
	emit_signal('end_turn_button')
