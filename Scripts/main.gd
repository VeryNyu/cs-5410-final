extends Node2D

var PLAYER: PackedScene = preload("res://Scenes/Player/player.tscn")
var player
var level: int = 0

func _ready() -> void:
	pass


func _on_game_start(key: String) -> void:
	if player:
		player.queue_free()
	print("Main Root (Game Start) Reporting: " + key)
	$LevelManager.change_level(key)
	
	match key:
		"One": level = 0
		"Two": level = 1
		"Three": level = 2
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
	
	player = PLAYER.instantiate()
	player.position = Config.DATA[level]["PlayerSpawnPoint"]
	add_child(player)


func _on_game_quit() -> void:
	get_tree().paused = false
	$LevelManager.hide()
	$UI/CanvasLayer/Hud.hide()
	player.queue_free()

func _on_goal() -> void:
	$UI/CanvasLayer/Hud.stop()
	var score: String = $UI/CanvasLayer/Hud/Score/Score.text
	var time: String = $UI/CanvasLayer/Hud/Time/Time.text
	SaveLoad.save_scores("???", level, score, time)

func _on_fruit_collected(points: int) -> void:
	$UI/CanvasLayer/Hud.score += points
