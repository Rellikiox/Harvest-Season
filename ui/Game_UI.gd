extends CanvasLayer

var UICard = preload('res://ui/Card.tscn')

var HeartFull = preload('res://assets/heart-full.png')
var HeartEmpty = preload('res://assets/heart-empty.png')

signal drag_position
signal drop_position

signal end_turn_button


func _ready():
	HUD_init()
	Gameover_init()
	
	
# HUD

func HUD_init():
	$HUD.visible = true
	discard_cards()	


func set_points(points):
	$HUD/Points.text = '%d Points' % points


func set_actions(left, total):
	$HUD/Actions.text = '%d/%d\nActions left' % [left, total]
	
	
func discard_cards():
	for card in $HUD/CardContainer.get_children():
		card.queue_free()
		
		
func discard_card(card):
	for ui_card in $HUD/CardContainer.get_children():
		if ui_card.card == card:
			ui_card.queue_free()
		

func set_cards(new_cards):
	for card in new_cards:
		var ui_card = UICard.instance()
		ui_card.card_type = card
		$HUD/CardContainer.add_child(ui_card)
		

func disable_cards():
	for card in $HUD/CardContainer.get_children():
		card.enable_interactions(false)
		

func _on_End_Turn_pressed():
	emit_signal('end_turn_button')


func set_n_lives(n_lives):
	for idx in range($HUD/LivesContainer.get_child_count()):
		var heart = $HUD/LivesContainer.get_child(idx)
		heart.texture = HeartFull if idx + 1 <= n_lives else HeartEmpty


# Gameover

func Gameover_init():
	$Gameover.visible = false
	
