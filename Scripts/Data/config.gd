extends Node

const VALUES: Dictionary = {
	"PinkGuy": 50,
	"NinjaFrog": 250,
	
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
			"PinkGuy": [
				Vector2i(325, 200),
				Vector2i(200, 110),
				Vector2i(856, 200),
				Vector2i(1456, 56),
				Vector2i(1712, 87),
				Vector2i(1824, 87),
				Vector2i(2700, 200),
				Vector2i(2800, 200),
				Vector2i(2750, 200),
				Vector2i(2568, 200),
				],
			"NinjaFrog": [
				Vector2i(1250, 200),
				Vector2i(2000, 200),
				Vector2i(3112, 200),
				Vector2i(3080, 200),
				Vector2i(3144, 200)
				]
		},
		"FruitSpawnPoints": {
			"Cherry": [
				Vector2i(296, 120),
				Vector2i(312, 120),
				Vector2i(328, 120),
				Vector2i(344, 120),
				Vector2i(360, 120),
				Vector2i(456, 168),
				Vector2i(472, 168),
				],
			"Strawberry": [],
			"Kiwi": [],
			"Orange": [
				Vector2i(296, 56),
				Vector2i(312, 56)
				],
			"Apple": [],
			"Banana": [
				Vector2i(168, 120),
				Vector2i(232, 120)],
			"Melon": [],
			"Pineapple": []
		}
	},
	1: {
		"PlayerSpawnPoint": Vector2i(26, 177),
		"EnemySpawnPoints": {
			"PinkGuy": [],
			"NinjaFrog": []
		},
		"FruitSpawnPoints": {
			"Cherry": [
				Vector2i(648, 136),
				Vector2i(728, 136)
			],
			"Strawberry": [
				Vector2i(936, 136),
				Vector2i(952, 136),
				Vector2i(968, 136),
				Vector2i(984, 136),
				Vector2i(1096, 136)
			],
			"Kiwi": [
				Vector2i(664, 88),
				Vector2i(680, 88),
				Vector2i(696, 88),
				Vector2i(712, 88)
			],
			"Orange": [
				Vector2i(664, 88),
				Vector2i(680, 88),
				Vector2i(696, 88),
				Vector2i(712, 88)
			],
			"Apple": [
				Vector2i(1352, 88),
				Vector2i(1368, 88),
				Vector2i(1384, 88),
				Vector2i(1400, 88),
				Vector2i(1416, 88),
				Vector2i(1432, 88)
			],
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
			"PinkGuy": [],
			"NinjaFrog": []
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
