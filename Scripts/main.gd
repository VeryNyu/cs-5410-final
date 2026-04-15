extends Node2D

var PLAYER: PackedScene = preload("res://Scenes/Player/player.tscn")
var FRUIT: PackedScene = preload("res://Scenes/Components/fruit.tscn")
var player
var level: int = 0

func _ready() -> void:
	pass


func _on_game_start(key: String) -> void:
	print("Main Root (Game Start) Reporting: " + key)
	$LevelManager.change_level(key)
	
	match key:
		"One": level = 0
		"Two": level = 1
		"Three": level = 2
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
	
	_spawn_objects()


func _spawn_objects():
	_spawn_player()
	_spawn_enemies()
	_spawn_fruits()


func _spawn_player():
	if player: player.queue_free()
	player = PLAYER.instantiate()
	player.position = Config.DATA[level]["PlayerSpawnPoint"]
	add_child(player)


func _spawn_enemies():
	pass


func _spawn_fruits():
	for node in get_tree().get_nodes_in_group("Fruits"): node.queue_free()
	var data = Config.DATA[level]["FruitSpawnPoints"]
	
	for Fruit in data:
		for location in data[Fruit]:
			var fruit = FRUIT.instantiate()
			fruit.position = location
			fruit.collect.connect(_on_fruit_collected)
			add_to_group("Fruits")
			add_child(fruit)


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
	$UI/CanvasLayer/Hud.text = $UI/CanvasLayer/Hud.score
