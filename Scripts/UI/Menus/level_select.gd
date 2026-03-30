extends Control

signal Level_Selected
signal Change


func _on_button_pressed(key: String) -> void:
	match key:
		"One", "Two", "Three":
			print("Level Select Sending Signal: " + key)
			Level_Selected.emit(key)
		"Back": Change.emit("Back")
