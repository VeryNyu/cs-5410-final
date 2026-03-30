extends Control

signal Change


func _on_button_pressed(key: String) -> void:
	match key:
		"Play": Change.emit("Level")
		"Leaderboard": Change.emit("Leaderboard")
		"Exit": get_tree().quit()
