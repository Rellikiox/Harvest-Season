extends Node

var sfx = {
	'delete.wav': preload('res://assets/audio/sfx/delete.wav'),
	'error.wav': preload('res://assets/audio/sfx/error.wav'),
	'harvest.wav': preload('res://assets/audio/sfx/harvest.wav'),
	'place_sprinkler.wav': preload('res://assets/audio/sfx/place_sprinkler.wav'),
	'plant_1.wav': preload('res://assets/audio/sfx/plant_1.wav'),
	'plant_2.wav': preload('res://assets/audio/sfx/plant_2.wav'),
	'plant_3.wav': preload('res://assets/audio/sfx/plant_3.wav'),
	'plant_4.wav': preload('res://assets/audio/sfx/plant_4.wav'),
	'plant_5.wav': preload('res://assets/audio/sfx/plant_5.wav'),
	'plant_6.wav': preload('res://assets/audio/sfx/plant_6.wav'),
	'plant_7.wav': preload('res://assets/audio/sfx/plant_7.wav'),
	'plant_8.wav': preload('res://assets/audio/sfx/plant_8.wav'),
	'refil_sprinkler.wav': preload('res://assets/audio/sfx/refil_sprinkler.wav'),
	'soil.wav': preload('res://assets/audio/sfx/soil.wav'),
	'watercan.wav': preload('res://assets/audio/sfx/watercan.wav')
}
var bgm = {
	'background.wav': preload("res://assets/audio/background/background.wav")	
}


func play_sfx(file):
	if file in sfx:
		play_file(sfx[file], 'SFX', $SFX)


func play_bgm(file):
	if file in bgm:
		play_file(bgm[file], 'Master', $BGM)
		

func play_file(stream, bus, node):
	var player = AudioStreamPlayer.new()
	node.add_child(player)
	player.bus = bus
	player.stream = stream
	player.play()
	yield(player, 'finished')
	player.queue_free()
	
	
func get_files_in_folder(folder):
	var dir = Directory.new()
	dir.open(folder)
	dir.list_dir_begin()
	var files = []
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()
	return files


func set_enabled(enabled):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), not enabled)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), not enabled)
