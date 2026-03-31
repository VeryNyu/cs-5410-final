extends Node2D

var PLAYER: PackedScene = preload("res://Scenes/Player/player.tscn")
var player
var level: int = 0

func _ready() -> void:
	pass


func _on_game_start(key: String) -> void:
	print("Main Root (Game Start) Reporting: " + key)
	$LevelManager.change_level(key)
	
	match key:
		"One": level = 0
		"Two": print("Level One Chosen")
		"Three": print("Level One Chosen")
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
	
	player = PLAYER.instantiate()
	player.position = Config.DATA[level]["PlayerSpawnPoint"]
	add_child(player)


func _on_game_quit() -> void:
	$LevelManager.hide()
	$UI/CanvasLayer/Hud.hide()
	player.queue_free()
	pass


func _on_goal() -> void:
	$UI/CanvasLayer/Hud.stop()
	pass # Replace with function body.
