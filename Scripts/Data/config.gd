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
		}
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
		}
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
