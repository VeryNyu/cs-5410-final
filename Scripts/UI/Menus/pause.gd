extends Control

signal Game_Start
signal Change


func _on_button_pressed(key: String) -> void:
	match key:
		"Continue": Change.emit("Continue")
		"Restart": Game_Start.emit("")
		"Level": Change.emit("Level")
		"Main": Change.emit("Start")
