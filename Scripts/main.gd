extends Node2D

func _ready() -> void:
	pass


func _on_game_start(key: String) -> void:
	print("Main Root (Game Start) Reporting: " + key)
	$LevelManager.change_level(key)
	
	match key:
		"One": print("Level One Chosen")
		"Two": print("Level One Chosen")
		"Three": print("Level One Chosen")
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
