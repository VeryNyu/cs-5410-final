extends Node

const VALUES: Dictionary = {
	"Pink Man": 50,
	"Ninja Frog": 200,
	
	"Cherry": 100,
	"Strawberry": 150,
	"Kiwi": 200,
	"Orange": 300,
	"Apple": 400,
	"Banana": 450,
	"Melon": 500,
	"Pineapple": 700
}

var DATA: Dictionary = {
	0: {
		"PlayerSpawnPoint": Vector2i(37, 201),
		"EnemySpawnPoints": {
			"Pink Man": [],
			"Ninja Frog": []
		},
		"FruitSpawnPoints": {
			"Cherry": [],
			"Strawberry": [],
			"Kiwi": [],
			"Orange": [],
			"Apple": [],
			"Banana": [],
			"Melon": [],
			"Pineapple": []
		}
	},
	1: {
		"PlayerSpawnPoint": Vector2i(26, 177),
		"EnemySpawnPoints": {
			"Pink Man": [],
			"Ninja Frog": []
		},
		"FruitSpawnPoints": {
			"Cherry": [],
			"Strawberry": [],
			"Kiwi": [],
			"Orange": [],
			"Apple": [],
			"Banana": [],
			"Melon": [],
			"Pineapple": []
		},
		"Coin Locations": [
			Vector2i(648, 136),
			Vector2i(728, 136),
			Vector2i(936, 136),
			Vector2i(952, 136),
			Vector2i(968, 136),
			Vector2i(984, 136),
			Vector2i(1096, 136),
			Vector2i(664, 88),
			Vector2i(680, 88),
			Vector2i(696, 88),
			Vector2i(712, 88),
			Vector2i(1352, 88),
			Vector2i(1368, 88),
			Vector2i(1384, 88),
			Vector2i(1400, 88),
			Vector2i(1416, 88),
			Vector2i(1432, 88),
		]
	},
	2: {
		"PlayerSpawnPoint": Vector2i(37, 101),
		"EnemySpawnPoints": {
			"Pink Man": [],
			"Ninja Frog": []
		},
		"FruitSpawnPoints": {
			"Cherry": [],
			"Strawberry": [],
			"Kiwi": [],
			"Orange": [],
			"Apple": [],
			"Banana": [],
			"Melon": [],
			"Pineapple": []
		},
		"Coin Locations": [
			Vector2i(1704, 152),
			Vector2i(1720, 88),
			Vector2i(1736, 152),
			Vector2i(1752, 88),
			Vector2i(1768, 152),
			Vector2i(1784, 88),
		]
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
