extends Node2D

var START

func _ready() -> void:
	START = $Ui/CanvasLayer/MenuManager
	#START.Game_Start.connect(_on_game_start(START.key))


func _on_game_start(key: String) -> void:
	print("Main Root (Game Start) Reporting: " + key)
	
	match key:
		"One": print("Level One Chosen")
		"Two": print("Level One Chosen")
		"Three": print("Level One Chosen")
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
