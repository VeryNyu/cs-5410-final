extends Node2D

var PLAYER_SCENE: PackedScene = preload("res://Scenes/Player/player.tscn")
var ENEMY_SCENES: Dictionary = {
	"NinjaFrog": preload("res://Scenes/Enemies/NinjaFrog.tscn"),
	"PinkGuy": preload("res://Scenes/Enemies/PinkGuy.tscn")
}
var FRUIT_SCENES: PackedScene = preload("res://Scenes/Components/fruit.tscn")

var player
var level: int = 0

func _ready() -> void:
	pass


func _on_game_start(key: String) -> void:
	match key:
		"One": level = 0
		"Two": level = 1
		"Three": level = 2
		"Restart": print("Level One Chosen")
		_: print("Defaulted Game Start")
		
	_spawn_objects()
	$LevelManager.change_level(key)

func _spawn_objects():
	_spawn_player()
	_spawn_enemies()
	_spawn_fruits()


func _spawn_player():
	if player: player.queue_free()
	player = PLAYER_SCENE.instantiate()
	player.position = Config.DATA[level]["PlayerSpawnPoint"]
	add_child(player)


func _spawn_enemies():
	for node in get_tree().get_nodes_in_group("Enemies"): node.queue_free()
	var data = Config.DATA[level]["EnemySpawnPoints"]
	
	for enemy_key in data:
		for location in data[enemy_key]:
			var enemy = ENEMY_SCENES[enemy_key].instantiate()
			enemy.position = location
			enemy.Defeated.connect(_on_enemy_defeated)
			enemy.add_to_group("Enemies")
			add_child(enemy)


func _spawn_fruits():
	var data = Config.DATA[level]["FruitSpawnPoints"]
	
	for Fruit in data:
		for location in data[Fruit]:
			var fruit = FRUIT_SCENES.instantiate()
			fruit.position = location
			fruit.value = Config.VALUES[Fruit]
			fruit.collect.connect(_on_fruit_collected)
			fruit.add_to_group("Fruits")
			add_child(fruit)


func _on_game_quit() -> void:
	get_tree().paused = false
	$LevelManager.hide()
	$UI/CanvasLayer/Hud.hide()
	_clear_entities()


func _clear_entities():
	player.queue_free()
	for node in get_tree().get_nodes_in_group("Enemies"): node.queue_free()
	for node in get_tree().get_nodes_in_group("Fruits"): node.queue_free()


func _on_goal() -> void:
	$UI/CanvasLayer/Hud.stop()
	var score: String = $UI/CanvasLayer/Hud/Score/Score.text
	var time: String = $UI/CanvasLayer/Hud/Time/Time.text
	SaveLoad.save_scores("???", level, score, time)


func _on_fruit_collected(points: int) -> void:
	$UI/CanvasLayer/Hud.score += points
	$UI/CanvasLayer/Hud/Score/Score.text = str($UI/CanvasLayer/Hud.score).pad_zeros(5)
	
func _on_enemy_defeated(points: int) -> void:
	$UI/CanvasLayer/Hud.score += points
	$UI/CanvasLayer/Hud/Score/Score.text = str($UI/CanvasLayer/Hud.score).pad_zeros(5)
