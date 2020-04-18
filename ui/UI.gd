extends Control

signal drag_position
signal drop_position



func can_drop_data(_position, data):
	emit_signal("drag_position", _position, data)
	return true


func drop_data(_position, data):	
	emit_signal("drop_position", _position, data)
