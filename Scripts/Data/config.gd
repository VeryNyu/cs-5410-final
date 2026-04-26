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
				Vector2i(2680, 200),
				Vector2i(2776, 200),
				Vector2i(2872, 200),
				Vector2i(2568, 200),
				],
			"NinjaFrog": [
				Vector2i(1250, 200),
				Vector2i(2000, 200),
				Vector2i(3112, 200),
				Vector2i(3080, 200),
				Vector2i(3144, 200),
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
				Vector2i(744, 136),
				Vector2i(760, 136),
				],
			"Strawberry": [
				Vector2i(1096, 72),
				Vector2i(1080, 72),
				Vector2i(1112, 72),
				Vector2i(1768, 88),
				Vector2i(1752, 88),
				Vector2i(1784, 88),
			],
			"Kiwi": [
				Vector2i(1464, 120),
				Vector2i(1480, 120),
				Vector2i(2072, 120),
				Vector2i(2088, 120),
			],
			"Orange": [
				Vector2i(296, 56),
				Vector2i(312, 56)
				],
			"Apple": [
				Vector2i(168, 120),
				Vector2i(232, 120),
				Vector2i(3080, 200),
				Vector2i(3144, 200),
			],
			"Banana": [
				Vector2i(2456, 216),
				Vector2i(2472, 216),
				],
			"Melon": [
				Vector2i(1250, 168),
				Vector2i(3112, 200),
			],
			"Pineapple": [
				Vector2i(1768, 136),
			]
		}
	},
	1: {
		"PlayerSpawnPoint": Vector2i(26, 177),
		"EnemySpawnPoints": {
			"PinkGuy": [
				Vector2i(280, 184),
				Vector2i(472, 200),
				Vector2i(744, 200),
				Vector2i(688, 104),
				Vector2i(920, 200),
				Vector2i(1200, 200),
				Vector2i(1968, 200),
			],
			"NinjaFrog": [
				Vector2i(1560, 200),
				Vector2i(2384, 200),
			]
		},
		"FruitSpawnPoints": {
			"Cherry": [
				Vector2i(648, 136),
				Vector2i(728, 136),
				Vector2i(1656, 152),
				Vector2i(1672, 152),
				Vector2i(1752, 136),
				Vector2i(1768, 136),
				Vector2i(1848, 168),
				Vector2i(1862, 168),
			],
			"Strawberry": [
				Vector2i(936, 136),
				Vector2i(952, 136),
				Vector2i(968, 136),
				Vector2i(984, 136),
				Vector2i(1096, 136),
				Vector2i(1240, 136),
				Vector2i(1256, 136),
			],
			"Kiwi": [
				Vector2i(664, 88),
				Vector2i(680, 88),
				Vector2i(696, 88),
				Vector2i(712, 88),
				Vector2i(664, 88),
				Vector2i(680, 88),
				Vector2i(696, 88),
				Vector2i(712, 88),
			],
			"Orange": [
				
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
			"Pineapple": [
				Vector2i(1168, 72),
			]
		},
	},
	2: {
		"PlayerSpawnPoint": Vector2i(37, 101),
		"EnemySpawnPoints": {
			"PinkGuy": [
				Vector2i(472, 144),
				Vector2i(504, 144),
				Vector2i(592, 128),
				Vector2i(850, 128),
				Vector2i(950, 128),
				Vector2i(1050, 128),
				Vector2i(1160, 128),
				Vector2i(1808, 192),
				Vector2i(1776, 192),
			],
			"NinjaFrog": [
				Vector2i(360, 144),
				Vector2i(1232, 144),
				Vector2i(1352, 144),
				Vector2i(1488, 144),
				Vector2i(1792, 192),
			],
			"BossFrog": [
				Vector2i(2232, 124)
			]
		},
		"FruitSpawnPoints": {
			"Cherry": [
				Vector2i(648, 96),
				Vector2i(744, 96),
				Vector2i(840, 96),
				Vector2i(904, 96),
				Vector2i(1000, 96),
				Vector2i(1096, 96),
			],
			"Strawberry": [
				Vector2i(1944, 192),
				Vector2i(1944, 176),
			],
			"Kiwi": [
				Vector2i(1704, 192),
				Vector2i(1736, 192),
				Vector2i(1768, 192),
				Vector2i(1800, 192),
			],
			"Orange": [
				Vector2i(408, 72),
				Vector2i(568, 72),
			],
			"Apple": [
				Vector2i(344, 88),
			],
			"Banana": [
				Vector2i(440, 216),
				Vector2i(536, 216),
			],
			"Melon": [
				Vector2i(1216, 64),
				Vector2i(1488, 64),
			],
			"Pineapple": [
				Vector2i(1352, 64),
			]
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
