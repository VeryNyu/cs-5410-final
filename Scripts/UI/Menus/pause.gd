extends Control

signal Game_Start
signal Change


func _on_button_pressed(key: String) -> void:
	match key:
		"Restart": Game_Start.emit("")
		"Level":
			Change.emit("Level")
			return
		"Main": Change.emit("Start")
