extends Node2D

var PLAYER: PackedScene = preload("res://Scenes/Player/player.tscn")
var player

func _ready() -> void:
	player = PLAYER.instantiate()


func _on_game_start(key: String) -> void:
	print("Main Root (Game Start) Reporting: " + key)
	$LevelManager.change_level(key)
	
	match key:
		"One": player.position = Vector2i(37, 201)
		"Two": print("Level One Chosen")
		"Three": print("Level One Chosen")
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
	
	add_child(player)


func _on_goal() -> void:
	$UI/CanvasLayer/Hud.stop()
	pass # Replace with function body.
