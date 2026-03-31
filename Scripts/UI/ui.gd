extends Control

signal Game_Start

var layer: TileMapLayer
var tileset: TileSet
var pattern: TileMapPattern


func _ready() -> void:
	layer = $Backdrop/TileMapLayer
	tileset = layer.tile_set


func _on_game_start(key: String) -> void:
	_draw_background()
	print("UI Signal Reached, Forwarding " + key)
	Game_Start.emit(key)
	$CanvasLayer/Hud.Game_Start()
	$CanvasLayer/MenuManager.pause(false)


func _draw_background():
	pattern = tileset.get_pattern(randi_range(0, 7))
	for x in range(0, 64, 4):
		for y in range(0, 64, 4):
			layer.set_pattern(Vector2i(x, y), pattern)
