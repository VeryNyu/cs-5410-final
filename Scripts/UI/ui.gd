extends Control

signal Game_Start


func _on_game_start(key: String) -> void:
	print("UI Signal Reached, Forwarding " + key)
	Game_Start.emit(key)
