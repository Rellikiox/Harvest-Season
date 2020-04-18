extends Control

var UICard = preload('res://ui/Card.tscn')

signal drag_position
signal drop_position

signal end_turn_button


func _ready():
	discard_cards()
	

func set_actions(left, total):
	$Actions.text = '%d/%d\nActions left' % [left, total]
	
	
func discard_cards():
	for card in $CardContainer.get_children():
		card.queue_free()
		

func set_cards(new_cards):
	for card in new_cards:
		var ui_card = UICard.instance()
		ui_card.card_type = card
		$CardContainer.add_child(ui_card)
		

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
