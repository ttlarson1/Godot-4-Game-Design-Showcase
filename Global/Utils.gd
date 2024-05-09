extends Node


const SAVE_PATH = "res://savegame.bin"
#game is refering to Game.gd i believe since it is a global variable that was made in project>settings>autoload


func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"PlayerHP": Game.playerHP,
		"Gold": Game.Gold,
 	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["PlayerHP"]
				Game.Gold = current_line["Gold"]
