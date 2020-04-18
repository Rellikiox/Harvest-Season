extends Control

onready var UI = get_parent()


func can_drop_data(_position, data):
	UI.emit_signal("drag_position", _position, data)
	return true


func drop_data(_position, data):	
	UI.emit_signal("drop_position", _position, data)
