extends Control


func can_drop_data(_pos, data):
	return true


func drop_data(_pos, data):
	print(_pos)
	print(data)
